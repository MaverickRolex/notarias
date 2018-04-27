class User < ApplicationRecord
  # devise :timeoutable, timeout_in: 60.minutes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :lockable, :masqueradable,
         :rememberable, :trackable, :validatable
  
  acts_as_paranoid

  has_many :procedures, class_name: "Procedure", foreign_key: :creator_user
  has_many :user_preferences
  has_many :preferences, through: :user_preferences
  has_many :permissions, as: :authorizable
  has_many :featurettes, through: :permissions
  has_many :groups, through: :user_groups
  has_many :user_groups, inverse_of: :user
  has_many :segments, through: :user_segments
  has_many :represented_segments, ->(o) { where('user_segments.representative = ?', true) }, through: :user_segments, class_name: "Segment"

  has_many :user_segments
  has_many :prep_processes
  has_many :evidences
  has_many :segment_messages
  # The idea is that the user is assigned to the Segment through :user_segment but also
  # the prep_processes are linked to :users and :segments as the tasks that they do for the segment
  has_many :processed_segments, through: :prep_processes, foreign_key: :user_id, class_name: 'Segment'

  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :username, uniqueness: true
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

  scope :common_users, -> { joins(user_roles: :role).where(roles: { id: Role.common.id }) }
  scope :admin_users, -> { joins(user_roles: :role).where(roles: { id: Role.admin.id }) }

  before_validation :set_username
  accepts_nested_attributes_for :permissions
  accepts_nested_attributes_for :user_groups, reject_if: :all_blank, allow_destroy: true
  attr_accessor :login, :prevalidate_username_uniqueness, :pre_encrypted_password

  def represents_segment?(segment)
    user_segments.where(segment: segment, representative: true).present?
  end

  def self.from_segment(segment)
    joins(:user_segments).where(user_segments: { segment_id: segment.id })
  end

  def self.non_representative_users_from_segment(segment)
    from_segment(segment).where("user_segments.representative = ? OR user_segments.representative IS NULL", false)
  end

  def set_username
    if prevalidate_username_uniqueness  == true
      if username.blank?
        self.username = full_name.gsub(" ", '')
      end
      while User.where(username: username).exists?  do
        self.username = username + "#{rand(00..99)}"
      end
    end
  end

  def represented_segments_and_descendant_ids
    self.represented_segments
      .map { |segment| segment.self_and_descendant_ids }.flatten
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end      
  end

  def lock_access!
    self.locked_at = Time.now.utc
    save  
  end

  def unlock_access!
    self.locked_at = nil
    save
  end

  def full_name
    [name,father_last_name,mother_last_name].join(" ")
  end

  def admin?
    roles.include?(Role.admin)
  end

  def super_admin?
    roles.include?(Role.super_admin)
  end

  def common?
    roles.include?(Role.common)
  end

  def representative?
    represented_segments.any? && common?
  end

  def root_segment
    if representative?
      represented_segments.first
    elsif admin? || super_admin?
      Segment.find_by(parent_id: nil)
    else
      nil
    end
  end
end

class User < ApplicationRecord
  # devise :timeoutable, timeout_in: 60.minutes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :lockable, :masqueradable,
         :rememberable, :trackable, :validatable

  has_many :procedures, class_name: "Procedure", foreign_key: :creator_user
  has_many :user_preferences
  has_many :preferences, through: :user_preferences
  has_many :permissions, as: :authorizable
  has_many :featurettes, through: :permissions
  has_many :groups, through: :user_groups
  has_many :user_groups, inverse_of: :user
  has_many :segments, through: :user_segments
  has_many :user_segments
  has_many :segments, through: :prep_processes
  has_many :prep_processes
  
  validates :username, uniqueness: true
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

  before_validation :set_username
  accepts_nested_attributes_for :permissions
  accepts_nested_attributes_for :user_groups, reject_if: :all_blank, allow_destroy: true
  attr_accessor :login, :prevalidate_username_uniqueness

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
end

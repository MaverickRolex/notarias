class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  SUPER_ADMIN_ROLE = 10
  ADMIN_ROLE = 100
  COMMON_ROLE = 200

  validates :name, presence: true
  validates :priority, presence: true

  def is_master?
    has_role(MASTER_ROLE) || is_super_admin?
  end

  def to_i
    self.priority
  end

  def ==(integer_role)
    self.to_i == integer_role
  end

  def <=(object)
    compare_error(object)
    self.to_i <= object.to_i
  end

  def >(object)
    compare_error(object)
    self.to_i > object.to_i
  end

  def compare_error(object)
    raise ArgumentError.
      new('comparison with role failed') unless object.respond_to? :to_i
  end

  private

  def constantized constant_name
    "#{self.class.name}::#{constant_name}".constantize
  end

  class << self
    def generate_is_method_name constant_name
      "is_#{constant_name.to_s.downcase.gsub('_role', '')}?"
    end

    def constant_role_names
      constants.select { |constant| constant.to_s.end_with?('_ROLE')  }
    end

    def instance_method_defined? method_name_as_string
      instance_methods.include?(method_name_as_string.to_sym)
    end

    def define_is_role_methods
      constant_role_names.each do |constant_name|
        method_name = generate_is_method_name(constant_name)
        next if instance_method_defined?(method_name)
        define_method(method_name) do
          has_role( constantized(constant_name) )
        end
      end
    end

    Role.constant_role_names.each do |constant_name|
      method_name = constant_name.to_s.downcase.gsub('_role', '')
      define_method(method_name) do
        find_by_priority(  "#{name}::#{constant_name}".constantize )
      end
    end
  end # class

  #########################
  # call to define is_role? methods when class loads
  define_is_role_methods
  #########################

  def has_role(role)
    self.priority == role
  end
end

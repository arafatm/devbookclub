class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :username, :login

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  include Gravtastic
  gravtastic

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
  end

end

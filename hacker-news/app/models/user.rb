class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  before_save :encrypt_password

  attr_accessible :name, :password, :password_confirmation
  attr_accessor :password, :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :password, on: :create, message: "- must provide that shit"

  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
class User < ApplicationRecord
  attr_accessor :remember_token
  before_save :downcase_email
  validates :name,
    presence: true,
    length: { maximum: 50 }

  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  validates :password,
    presence: true,
    length: { minimum: 6 },
    allow_nil: true
  # you can use password & password_confirmation attribute
  # and authenticate method
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private
  def downcase_email
    email.downcase!
    # self.email = email.downcase
  end
end

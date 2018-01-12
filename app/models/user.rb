class User < ApplicationRecord
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
    length: { minimum: 6 }
  # you can use password & password_confirmation attribute
  # and authenticate method
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private
  def downcase_email
    email.downcase!
    # self.email = email.downcase
  end
end

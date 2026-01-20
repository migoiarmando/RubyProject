# User model for authentication and profile management
class User < ApplicationRecord
  # Password encryption using bcrypt
  has_secure_password

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }
  validates :role, inclusion: { in: %w[user admin] }

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  # Instance methods
  # Check if user is an admin
  def admin?
    role == 'admin'
  end

  # Check if user is a regular user
  def regular_user?
    role == 'user'
  end
end

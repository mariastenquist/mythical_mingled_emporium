class User < ApplicationRecord
  has_secure_password
  
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  has_many :orders

  enum role: %w(user admin)
end

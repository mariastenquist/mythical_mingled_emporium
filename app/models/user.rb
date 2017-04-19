class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates_uniqueness_of :username, case_sensitive: false

  has_many :orders, dependent: :nullify

  enum role: %w(user admin)
end

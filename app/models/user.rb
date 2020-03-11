class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  has_many :memos

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true


end

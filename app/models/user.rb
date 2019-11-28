class User < ApplicationRecord
  has_secure_password

  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :nickname, presence: true, uniqueness: true

  has_many :posts, foreign_key: :created_by, primary_key: :nickname
end

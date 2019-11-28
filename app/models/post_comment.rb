class PostComment < ApplicationRecord

  validates :content, presence: true
  validates :created_by, presence: true

  belongs_to :user, foreign_key: :created_by, primary_key: :nickname
  belongs_to :post

  has_many :comment_comments

end

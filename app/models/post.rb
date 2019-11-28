class Post < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :created_by, presence: true

  belongs_to :user, foreign_key: :created_by, primary_key: :nickname
  belongs_to :category

  has_many :post_comments, dependent: :destroy

  def upvote!
    self.update!(upvotes: self.upvotes + 1)
  end

end

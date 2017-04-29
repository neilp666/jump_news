class Link < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :url,
            format: { with: %r{\Ahttps?://} },
            allow_blank: true

  has_many :comments
  belongs_to :votes

  def comment_count
    comments.length
  end

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end
end

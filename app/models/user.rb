class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true,
                       length: { minimum: 3},
                       uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 8}

  has_many :links, dependent: :destroy

  def owns_link?(link)
    self == link.user
  end

  def owns_comment?(comment)
    self == comment.user
  end

  def upvote(link)
    votes.create(upvote: 1 , link: link)
  end

  def downvote(link)
    votes.create(downvote: 1, link: link)
  end

  has_many :comments
  belongs_to :votes

  def upvoted?(link)
    votes.exists?(upvote: 1, link: link)
  end

  def downvoted?(link)
    votes.exists?(downvote: 1, link: link)
  end

  def remove_vote(link)
    votes.find_by(link: link).destroy
  end

end

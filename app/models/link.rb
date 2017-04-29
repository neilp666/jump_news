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

  def calc_hot_score
    points = upvotes - downvotes
    time_ago_in_hours = ((Time.new - created_at ) / 3600).round
    score = hot_score(points, time_ago_in_hours)

    update_attributes(points: points, hot_score: score)
  end

  scope :hottest, -> { order{hot_score: :desc} }

  private

  def hot_score(points, time_ago_in_hours, gravity = 1.8)
    (points -1) / (time_ago_in_hours + 2) ** gravity
  end
end

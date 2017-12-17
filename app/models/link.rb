class Link < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :url, format: { with: %r{\Ahttps?://} }, allow_blank: true
  has_many :comments
  has_many :votes

  scope :hottest, -> {order(hot_score: :desc)}
  scope :newest, -> {order(created_at: :desc)}

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
    time_ago_in_hours = ((Time.now - created_at) / 3600).round
    score = hot_score(points, time_ago_in_hours)

    update_attributes(points: points, hot_score: score)
  end

  private

  def hot_score(points, time_ago_in_hours, gravity = 1.8)
    # one is subtracted from available points because every link by default has one point
    # There is no reason for picking 1.8 as gravity, just an arbitrary value
    (points - 1) / (time_ago_in_hours + 2) ** gravity
  end
end

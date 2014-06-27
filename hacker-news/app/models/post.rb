class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_votes
  has_many :upvoters, through: :post_votes, source: :user

  attr_accessible :title, :url, :user_id

  validates_presence_of :title, on: :create, message: "- must provide that shit"
  validates_presence_of :url, on: :create, message: "- must provide that shit"

  scope :by_most_recent, order('created_at desc')
  scope :by_most_popular, order('post_votes_count desc')

  def upvote_count
    post_votes.count('is_upvote')
  end

  def username
    user.name
  end
end

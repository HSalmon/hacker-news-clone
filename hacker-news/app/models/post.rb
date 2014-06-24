class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  attr_accessible :title, :url

  validates_presence_of :title, on: :create, message: "- must provide that shit"
  validates_presence_of :url, on: :create, message: "- must provide that shit"
end
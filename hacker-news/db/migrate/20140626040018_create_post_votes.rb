class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.boolean :is_upvote, default: true
      t.belongs_to :post
      t.belongs_to :user
    end
  end
end

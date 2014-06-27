class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.boolean :is_upvote, default: true
      t.belongs_to :comment
      t.belongs_to :user
    end
  end
end

class AddUpvotesCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_votes_count, :integer, default: 0
  end
end

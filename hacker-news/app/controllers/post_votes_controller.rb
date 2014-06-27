class PostVotesController < ApplicationController

  def create
    post = Post.find_by_id(params[:id])
    if post.upvoters.include?(current_user)
      render nothing: true, status: ok
    else
      post.upvoters << current_user
      render json: { upvotes: post.upvote_count }
    end
  end
end

class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def user_comments
    @comments = Comment.where('user_id == ?', params[:id])
    render :index
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@comment.post), :notice => "Successful comment creation!"
    else
      render :new
    end
  end
end
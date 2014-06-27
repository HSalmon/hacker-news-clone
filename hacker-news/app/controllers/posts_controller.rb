class PostsController < ApplicationController

  def index
    @posts = Post.by_most_popular
  end

  def show
    @post = Post.find_by_id(params[:id])
    @comments = @post.comments
  end

  def user_posts
    @posts = Post.where('user_id == ?', params[:id])
    render :index
  end

  def new
    unless current_user.present?
      redirect_to sign_up_path, :notice => "Gotta sign in to submit!"
    end
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_url, :notice => "Successful post creation!"
    else
      render :new
    end
  end

  def most_recent
    @posts = Post.by_most_recent
    render :index
  end
end

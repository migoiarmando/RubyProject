# Admin controller for post management
class Admin::PostsController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # List all posts for admin management
  def index
    @posts = Post.includes(:user, :comments, :reactions).recent
  end

  # Show post - redirect to regular post show page
  def show
    redirect_to post_path(@post)
  end

  # Edit any post (admin override)
  def edit
  end

  # Update any post (admin override)
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete any post (admin override)
  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post deleted successfully.'
  end

  private

  # Set the post from params
  def set_post
    @post = Post.find(params[:id])
  end

  # Strong parameters
  def post_params
    params.require(:post).permit(:title, :content, :image_url)
  end
end

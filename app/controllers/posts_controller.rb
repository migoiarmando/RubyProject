# Web UI controller for posts - handles HTML requests
class PostsController < ApplicationController
  # Require login for all actions except index and show
  before_action :require_login, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post_owner, only: [:edit, :update, :destroy]

  # List all posts - public (but shows more options if logged in)
  def index
    @posts = Post.includes(:user, :comments, :reactions).recent
  end

  # Show a single post - public
  def show
    @post = Post.includes(:user, comments: :user, reactions: :user).find(params[:id])
    @comment = Comment.new
  end

  # Display form to create a new post - requires login
  def new
    @post = Post.new
  end

  # Create a new post - requires login
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Display form to edit an existing post - requires ownership or admin
  def edit
  end

  # Update an existing post - requires ownership or admin
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete a post - requires ownership or admin
  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private

  # Set the post from params
  def set_post
    @post = Post.find(params[:id])
  end

  # Authorization - only allow post owner or admin to edit/delete
  def authorize_post_owner
    unless current_user == @post.user || current_user&.admin?
      flash[:alert] = 'You can only edit or delete your own posts.'
      redirect_to @post
    end
  end

  # Strong parameters - allow title, content, and image_url
  def post_params
    params.require(:post).permit(:title, :content, :image_url)
  end
end

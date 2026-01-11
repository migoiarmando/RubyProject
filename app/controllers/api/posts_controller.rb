# API controller for posts - handles JSON requests
class Api::PostsController < ApplicationController
  # Skip CSRF protection for API endpoints
  skip_before_action :verify_authenticity_token

  # List all posts (JSON)
  def index
    @posts = Post.all.order(created_at: :desc)
    render json: @posts
  end

  # Show a single post (JSON)
  def show
    @post = Post.find(params[:id])
    render json: @post
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  # Create a new post (JSON)
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update an existing post (JSON)
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  # Delete a post (JSON)
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    render json: { message: 'Post was successfully deleted.' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  private

  # Strong parameters - only allow title and content
  def post_params
    params.require(:post).permit(:title, :content)
  end
end

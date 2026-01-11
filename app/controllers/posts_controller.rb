# Web UI controller for posts - handles HTML requests
class PostsController < ApplicationController
  # List all posts
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # Show a single post
  def show
    @post = Post.find(params[:id])
  end

  # Display form to create a new post
  def new
    @post = Post.new
  end

  # Create a new post
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Display form to edit an existing post
  def edit
    @post = Post.find(params[:id])
  end

  # Update an existing post
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete a post
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private

  # Strong parameters - only allow title and content
  def post_params
    params.require(:post).permit(:title, :content)
  end
end

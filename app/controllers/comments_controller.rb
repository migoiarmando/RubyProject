# Controller for handling post comments
class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_post
  before_action :set_comment, only: [:destroy, :update]

  # Create a new comment on a post
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment added successfully.'
    else
      flash[:alert] = 'Error adding comment. Please try again.'
      redirect_to @post
    end
  end

  # Update an existing comment
  def update
    # Only allow comment owner or admin to update
    unless current_user == @comment.user || current_user.admin?
      flash[:alert] = 'You can only edit your own comments.'
      redirect_to @post and return
    end

    if @comment.update(comment_params)
      redirect_to @post, notice: 'Comment updated successfully.'
    else
      flash[:alert] = 'Error updating comment.'
      redirect_to @post
    end
  end

  # Delete a comment
  def destroy
    # Only allow comment owner or admin to delete
    unless current_user == @comment.user || current_user.admin?
      flash[:alert] = 'You can only delete your own comments.'
      redirect_to @post and return
    end

    @comment.destroy
    redirect_to @post, notice: 'Comment deleted successfully.'
  end

  private

  # Set the post from nested route
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Set the comment from params
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  # Strong parameters for comments
  def comment_params
    params.require(:comment).permit(:content)
  end
end

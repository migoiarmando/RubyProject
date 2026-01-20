# Controller for handling post reactions (like, heart, etc.)
class ReactionsController < ApplicationController
  before_action :require_login
  before_action :set_post

  # Create a new reaction or toggle existing reaction
  def create
    reaction_type = params[:reaction_type]
    
    # Validate reaction type
    unless Reaction.reaction_types.include?(reaction_type)
      flash[:alert] = 'Invalid reaction type.'
      redirect_to @post and return
    end

    # Find existing reaction of this type by this user
    existing_reaction = @post.reactions.find_by(user: current_user, reaction_type: reaction_type)

    if existing_reaction
      # If reaction exists, destroy it (toggle off)
      existing_reaction.destroy
      flash[:notice] = 'Reaction removed.'
    else
      # Remove any other reaction by this user on this post (only one reaction type per user per post)
      @post.reactions.where(user: current_user).destroy_all
      
      # Create new reaction
      @post.reactions.create(user: current_user, reaction_type: reaction_type)
      flash[:notice] = 'Reaction added.'
    end

    redirect_back(fallback_location: @post)
  end

  # Destroy a reaction
  def destroy
    @reaction = @post.reactions.find(params[:id])
    
    # Only allow reaction owner to delete
    if @reaction.user == current_user
      @reaction.destroy
      flash[:notice] = 'Reaction removed.'
    else
      flash[:alert] = 'You can only remove your own reactions.'
    end

    redirect_to @post
  end

  private

  # Set the post from nested route
  def set_post
    @post = Post.find(params[:post_id])
  end
end

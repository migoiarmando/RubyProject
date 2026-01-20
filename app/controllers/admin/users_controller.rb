# Admin controller for user management
class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_user, only: [:show, :destroy]

  # List all users
  def index
    @users = User.includes(:posts, :comments).order(created_at: :desc)
  end

  # Show user - redirect to users index (no user profile page in admin)
  def show
    redirect_to admin_users_path
  end

  # Delete a user
  def destroy
    # Prevent admin from deleting themselves
    if @user == current_user
      flash[:alert] = 'You cannot delete your own account.'
    else
      @user.destroy
      flash[:notice] = 'User deleted successfully.'
    end
    redirect_to admin_users_path
  end

  private

  # Set the user from params
  def set_user
    @user = User.find(params[:id])
  end
end

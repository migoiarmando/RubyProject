# Controller for handling user registration
# Only allows registration of regular users (not admins)
class RegistrationsController < ApplicationController
  # No login required for registration actions

  # Display registration form
  def new
    # Redirect to home if already logged in
    redirect_to root_path if logged_in?
    @user = User.new
  end

  # Create new user account
  def create
    @user = User.new(user_params)
    # Always set role to 'user' - admins can only be created via seeds or console
    @user.role = 'user'

    if @user.save
      # Automatically log in the new user
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}! Your account has been created successfully."
      redirect_to root_path
    else
      # Display errors and re-render form
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters - only allow specific user attributes
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :full_name, :bio)
  end
end

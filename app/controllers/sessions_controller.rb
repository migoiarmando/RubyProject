# Controller for handling user login and logout sessions
class SessionsController < ApplicationController
  # No login required for login/logout actions

  # Display login form
  def new
    # Redirect to home if already logged in
    redirect_to root_path if logged_in?
  end

  # Create new session (login)
  def create
    # Find user by email
    user = User.find_by(email: params[:email])

    # Authenticate user with password
    if user && user.authenticate(params[:password])
      # Set session and redirect
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.username}!"
      redirect_to root_path
    else
      # Invalid credentials
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  # Destroy session (logout)
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have been logged out.'
    redirect_to root_path
  end
end

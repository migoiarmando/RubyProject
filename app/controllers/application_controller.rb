class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Authentication helpers
  # Get the current logged-in user from session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Make current_user and logged_in? available to views
  helper_method :current_user, :logged_in?

  # Check if user is logged in
  def logged_in?
    !!current_user
  end

  # Require user to be logged in to access certain actions
  def require_login
    unless logged_in?
      flash[:alert] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end

  # Require user to be an admin
  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'You must be an admin to access this page.'
      redirect_to root_path
    end
  end
end


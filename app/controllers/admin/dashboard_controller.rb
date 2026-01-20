# Admin dashboard controller
class Admin::DashboardController < ApplicationController
  before_action :require_login
  before_action :require_admin

  # Display admin dashboard with statistics
  def index
    @total_users = User.count
    @total_posts = Post.count
    @total_comments = Comment.count
    @total_reactions = Reaction.count
    @recent_posts = Post.includes(:user).recent.limit(5)
    @recent_users = User.order(created_at: :desc).limit(5)
  end
end

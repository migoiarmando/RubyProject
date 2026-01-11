Rails.application.routes.draw do
  # Web UI routes for posts
  resources :posts

  # API routes for posts (JSON)
  namespace :api do
    resources :posts, defaults: { format: :json }
  end

  # Root route - redirect to posts index
  root 'posts#index'
end

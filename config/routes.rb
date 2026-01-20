Rails.application.routes.draw do
  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/register', to: 'registrations#new'
  post '/register', to: 'registrations#create'

  # Posts routes with nested comments and reactions
  resources :posts do
    resources :comments, only: [:create, :destroy, :update]
    resources :reactions, only: [:create, :destroy]
  end

  # Admin namespace
  namespace :admin do
    root 'dashboard#index'
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end

  # API routes for posts (JSON) - kept for backward compatibility
  namespace :api do
    resources :posts, defaults: { format: :json }
  end

  # Root route - redirect to posts index
  root 'posts#index'
end

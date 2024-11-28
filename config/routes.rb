Rails.application.routes.draw do
  resources :comments
  resources :likes, only: [:create, :destroy]

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
    get '/users/password', to: 'devise/passwords#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
  get "home/about"
  get "posts/myposts"

  # Search route (uses the index action for search functionality)
  get 'posts/search', to: 'posts#index', as: :search_posts

  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check
  root "posts#index"
end

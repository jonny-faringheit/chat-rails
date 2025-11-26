require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq web UI - protect with authentication in production
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, module: "users", path_names: {
    sign_in: "signin", sign_out: "logout", sign_up: "signup"
  }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount ActionCable.server => '/cable'
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'mains#index'

  get '/chats', to: 'conversations#index', as: :chats
  get '/chats/:receiver', to: 'conversations#show', as: :show_chat
  post '/chats/:receiver', to: 'conversations#create', as: :new_chat

  resources :videos, only: [:index]
  resources :musics, only: [:index]

  resources :achievements, only: [:index]

  # User search endpoint
  get '/users/search', to: 'users#search', as: :search_users

  # User profiles with username in URL
  get '/:username', to: 'users#show', as: :user, constraints: { username: /[a-zA-Z0-9._-]+/ }
end

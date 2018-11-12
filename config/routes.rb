Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'development/sessions#login_as'
  end

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  namespace :users do
    get 'auth/:provider', to: 'oauths#oauth', as: :auth_at_provider
    get 'auth/twitter/callback', to: 'oauths#callback'
    resources :oauths, only: %i[new create]
  end

  resources :tops, only: :index
  resources :users, only: %i[new create]

  namespace :mypage do
    root to: 'dashboards#index'
  end

  root 'tops#index'
end

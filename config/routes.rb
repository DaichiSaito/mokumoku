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
  resources :users, only: %i[new create show]
  resources :mokumokus, only: %i[show] do
    resources :attends, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end

  namespace :mypage do
    root to: 'dashboards#index'
    get '/dashboards/schedule', to: 'dashboards#schedule'
    resources :mokumokus, only: %i[index new create edit update]
    resource :user, only: %i[edit update]
  end

  root 'tops#index'
end

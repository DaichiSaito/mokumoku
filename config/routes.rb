Rails.application.routes.draw do
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :tops, only: :index
  resources :users, only: %i[new create]
  resources :mokumokus, only: %i[show]

  namespace :mypage do
    root to: 'dashboards#index'
    resources :mokumokus
  end

  root 'tops#index'
end

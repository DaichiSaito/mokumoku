Rails.application.routes.draw do
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :tops, only: :index
  resources :users, only: %i[new create]

  root 'tops#index'
end

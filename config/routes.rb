Rails.application.routes.draw do
  if Rails.env.development?
    get '/login_as/:user_id', to: 'development/sessions#login_as'
    mount LetterOpenerWeb::Engine, at: '/letter_opener'

    scope module: :development do
      resources :users, only: %i[new create]
    end
  end

  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  get '/term' => 'tops#term'

  namespace :users do
    get 'auth/:provider', to: 'oauths#oauth', as: :auth_at_provider
    get 'auth/twitter/callback', to: 'oauths#callback'
    resources :oauths, only: %i[new create]
  end

  namespace :mokumokus do
    get '/search', to: 'search#index'
  end

  resources :tops, only: :index
  resources :mokumokus, only: %i[show] do
    resources :attends, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
  end

  namespace :mypage do
    root to: 'dashboards#index'
    get '/dashboards/schedule', to: 'dashboards#schedule'
    resources :mokumokus, only: %i[new create edit update show] do
      collection do
        get :futures
        get :pasts
      end
    end
    resource :user, only: %i[edit update]
    resources :notifications, only: %i[index]
    get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  end

  root 'tops#index'
end

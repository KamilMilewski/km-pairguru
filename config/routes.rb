Rails.application.routes.draw do
  devise_for :users
  root 'home#welcome'

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:show, :index]
    end

    namespace :v2 do
      resources :movies, only: [:show, :index]
    end
  end

  resources :genres, only: :index do
    member do
      get 'movies'
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end

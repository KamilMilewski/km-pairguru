Rails.application.routes.draw do
  get 'profiles/index'

  get 'profiles/show'

  get 'profiles/edit'

  get 'profiles/update'

  devise_for :users
  root 'home#welcome'

  resources :profiles

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

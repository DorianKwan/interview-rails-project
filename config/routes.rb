Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts, only: [:index, :show] do
    collection do
      get :top
    end
    member do
      post :upvote
    end
  end

  resources :users, only: [:show]

  resource :session, only: [:new] do
    collection do
      post :login
      get :logout
    end
  end

  resources :categories, only: [:show]

  root "home#index"
end

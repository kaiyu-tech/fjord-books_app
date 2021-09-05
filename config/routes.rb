Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'

  resources :users do
    member do
      get :followings, :followers
    end
  end

  resources :books
  resources :users, only: %i(index show)
  resources :follows, only: %i(create destroy)
end

Rails.application.routes.draw do

  devise_for :users

  root 'books#index'

  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'

  resources :users
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

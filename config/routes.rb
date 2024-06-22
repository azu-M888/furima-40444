Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  # resources :users, only: [:show,:new]
  # resources :items, only: [:show,:index]
  # resources :orders do
  #  resources :addresses,only: [:create]
  # end
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:show,:index,:new,:edit,:update]
  # resources :orders do
  #  resources :addresses,only: [:create]
  # end
end

Rails.application.routes.draw do
  devise_for :users
  resources :groups

  resources :items

  resources :lists

  root to: "home#index"
end

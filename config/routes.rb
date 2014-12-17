Rails.application.routes.draw do
  devise_for :users
  resources :lists
  resources :groups

  root to: "home#index"
end

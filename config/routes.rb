Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :lists
  resources :groups do
    resources :invitations
  end

  root to: "home#index"
end

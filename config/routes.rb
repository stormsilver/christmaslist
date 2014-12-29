Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}

  resources :lists, only: [:show] do
    resources :items
  end

  resources :groups do
    resources :invitations
    resources :lists, only: [] do
      resources :items
    end
  end

  root to: "home#index"
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  resources :products, only: [:index, :show] do
    resources :orders, only: [:create]
  end

  resources :carts, only: [:show] do
    resources :payments, only: [:create]
  end

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

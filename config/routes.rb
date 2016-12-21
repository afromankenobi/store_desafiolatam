Rails.application.routes.draw do
  scope :dashboard, as: :dashboard do
    root 'dashboard#index'
    get 'index', to: 'dashboard#index'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  resources :products, only: [:index, :show] do
    resources :orders, only: [:create]
  end

  resources :carts, only: [:show] do
    resources :cart_payments, only: [:create] do
      collection do
        get 'done'
        get 'cancel'
        get 'payments'
      end
    end
  end

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

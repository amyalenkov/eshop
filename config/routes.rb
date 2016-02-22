Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

  resources :products, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :destroy]
  resources :orders, only: [:index, :create, :show] do
    member do
      post 'choice_payment'
    end
  end
  resources :rows, only: [:index, :create, :show]

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'products#index'

end

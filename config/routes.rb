Rails.application.routes.draw do

  get 'cart_items/create'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#index'

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :index]

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'products#index'

end

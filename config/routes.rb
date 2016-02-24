Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#index'

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

  resources :products, only: [:index, :show] do
    collection do
      post 'search_ajax'
      get 'search'
    end
  end
  resources :cart_items, only: [:index, :create, :destroy]
  resources :orders, only: [:index, :create, :show]

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'products#index'

end

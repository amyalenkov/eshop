Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

  resources :products, only: [:index, :show] do
    collection do
      post 'search_ajax'
      get 'search'
    end
  end
  resources :cart_items, only: [:index, :create, :destroy]
  resources :orders, only: [:index, :create, :show] do
    member do
      post 'choice_payment'
    end
    collection do
      get 'meetings'
    end
  end
  resources :rows, only: [:index, :create, :show, :update]
  resources :comments, only: [:create, :show, :update]
  resources :favorites, only: [:index, :create, :destroy]

  post '/rate' => 'rater#create', :as => 'rate'

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'products#index'

end

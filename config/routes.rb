Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {confirmations: 'users/confirmations', registrations: 'users/registrations'}

  resources :users

  resources :products, only: [:index, :show] do
    collection do
      post 'search_ajax'
      get 'search'
    end
  end
  resources :cart_items, only: [:index, :create, :destroy]
  resources :order_items, only: [:update, :destroy]
  resources :orders, only: [:index, :create, :show] do
    member do
      post 'choice_delivery'
      get 'current_order'
    end
    collection do
      get 'meetings'
      post 'set_state_order'
      post 'set_state_order_item'
      post 'filter'
    end
  end
  resources :rows, only: [:index, :create, :show, :update, :destroy] do
    collection do
      post 'set_state'
      post 'filter'
    end
  end
  resources :comments, only: [:create, :show, :update, :destroy]
  resources :row_comments, only: [:create, :show, :update, :destroy]
  resources :favorites, only: [:index, :create, :destroy]

  post '/rate' => 'rater#create', :as => 'rate'

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'static_pages#category_list'

  get 'static_pages/faq' => 'static_pages#faq'
  get 'static_pages/about_us' => 'static_pages#about_us'
  get 'static_pages/for_you' => 'static_pages#for_you'
  get 'static_pages/review' => 'static_pages#review'
  get 'static_pages/questions' => 'static_pages#questions'

  resources :application
  post 'static_pages/order_call'


end

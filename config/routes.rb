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
      post 'sorted_by'
    end
  end
  resources :cart_items, only: [:index, :create, :destroy, :update] do
    member do
      post 'add_comment'
    end
  end
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
  resources :questions, only: [:create, :show, :update, :destroy]
  resources :reviews, only: [:create, :show, :update, :destroy]
  resources :answers, only: [:create, :show, :update, :destroy]
  resources :row_comments, only: [:create, :show, :update, :destroy]
  resources :favorites, only: [:index, :create, :destroy]

  post '/rate' => 'rater#create', :as => 'rate'

  get '/subcategory/:name' => 'products#index'
  get '/category/:name' => 'static_pages#category_list'

  get 'static_pages/faq' => 'static_pages#faq'
  get 'static_pages/news' => 'static_pages#news'
  get 'static_pages/about_us' => 'static_pages#about_us'
  get 'static_pages/for_you' => 'static_pages#for_you'
  get 'static_pages/review' => 'static_pages#review'
  get 'static_pages/get_datetime_for_stop' => 'static_pages#get_datetime_for_stop'
  get 'static_pages/close_form' => 'static_pages#close_form'
  get 'static_pages/confirm_registration' => 'static_pages#confirm_registration'

  resources :application
  post 'static_pages/order_call'

  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unacceptable'
  get '/500', :to => 'errors#internal_error'

  %w( 404 422 500 ).each do |code|
    get code, :to => 'errors#show', :code => code
  end




end

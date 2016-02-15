Rails.application.routes.draw do

  root 'static_pages#index'

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

end

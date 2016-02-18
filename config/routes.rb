Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#index'

  devise_for :users, controllers: {confirmations: 'users/confirmations'}

  resources :users

end

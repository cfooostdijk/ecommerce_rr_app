Rails.application.routes.draw do
  root 'homepage#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create]
      resources :products, only: [:index]
    end
  end
end

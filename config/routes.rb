Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'homepage#index'
  resources :products, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create]
    end
  end
end

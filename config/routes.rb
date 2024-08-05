require 'sidekiq/web'

Rails.application.routes.draw do
  root 'homepage#index'
  get '/catalog', to: 'catalog#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:create]
      resources :products, only: [:index, :show] do
        collection { post :import }
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end

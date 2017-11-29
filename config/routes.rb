Rails.application.routes.draw do
  config = Rails.application.config.baukis


  constraints host: config[:staff][:host] do
    namespace :staff, path: '' do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resources :staff_members
      resource :session, only: [ :create, :destroy ]
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end

  root 'errors#routing_error'
  get '*anything' => 'errors#routing_error'
end

Rails.application.routes.draw do
  get 'categories/index'
  root to: 'top#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get  'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :products, except: [:show]

  resources :products, only: [:index, :new, :edit, :destroy] do
    collection do
      get 'get_category_children',      defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :brands, only: [:new, :create]

  resources :accounts, only: [:index, :show] do
    collection do
      get 'logout', to: 'accounts#logout'
    end
  end

  resources :creditcards, only: [:index ,:new, :create, :show] do
    collection do
      delete 'delete', to: 'creditcards#delete'
      post   "date",   to: 'creditcards#show'
    end
  end
end

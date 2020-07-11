Rails.application.routes.draw do
  root to: 'top#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
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
end

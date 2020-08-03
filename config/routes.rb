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

  resources :products do
    collection do
      get 'get_category_children',      defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'fuzzy_search', to: 'products#fuzzy_search'
    end
    member do
      get 'purchase', to: 'products#purchase'
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






  resources :categories, only: [:index, :show]

  resources :top, only: [:index] do
    collection do
      get :search
    end
  end


  resources :categories, only: [:index, :show]

end

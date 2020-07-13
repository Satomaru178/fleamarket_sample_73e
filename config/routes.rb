Rails.application.routes.draw do
  root to: 'top#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  resources :accounts, only: [:index, :show] do
    collection do
      get 'logout', to: 'accounts#logout'
    end
  end
  resources :creditcards, only: [:index ,:new, :create, :show] do
    collection do
      delete 'delete', to: 'creditcards#delete'
    end
  end
end

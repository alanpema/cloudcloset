Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "dashboard", to: "pages#dashboard"
  get "confirmation/:id", to: "pages#confirmation", as: :confirmation
  get "get_item/:id", to: "items#get_item", as: :get_item
  resources :items, only: [:show, :new, :create, :edit, :update, :destroy, :index]

  resources :closets, only: [:show, :new, :create, :update, :destroy, :index] do
    resources :bookings, only: [:new, :create, :show, :edit, :update]
  end
  resources :bookings, only: [:destroy]

  # Defines the root path route ("/")
  # root "posts#index"
end

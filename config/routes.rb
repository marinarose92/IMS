Rails.application.routes.draw do
  root 'sessions#new'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'sessions', to: 'orders#index', as: 'index'

  resources :orders
  resources :vendors
  resources :libraries
  resources :products

  mount PgHero::Engine, at: "pghero"
  end

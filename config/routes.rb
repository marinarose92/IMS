Rails.application.routes.draw do
  root to: 'orders#index'

  resources :orders
  resources :vendors
  resources :libraries
  resources :products
  end

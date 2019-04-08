Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/register', to: 'users#new', as: :registration
  post '/register', to: 'users#create'

  get '/cart', to: 'cart#show'
  get '/cart/:item_id', to: 'cart#update', as: :update_cart

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]

  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit', to: 'users#edit', as: :edit_profile
  patch '/profile/edit', to: 'users#update'
  namespace :profile do
    resources :orders, only: [:index, :show, :destroy]
  end

  namespace :dashboard do
    get '/', to: 'dashboard#index'
    resources :items, only: [:index, :show, :new]
    put '/order_items/:order_item_id/fulfill', to: 'orders#fulfill', as: 'fulfill_order_item'
    resources :orders, only: [:show]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only: [:index, :show]
    resources :merchants, only: [:show] do
      resources :items, only: [:index, :new]
      resources :orders, only: [:show]
    end
  end
end

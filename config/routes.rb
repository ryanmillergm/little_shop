Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/register', to: 'users#new', as: :registration
  post '/register', to: 'users#create'

  get '/cart', to: 'cart#show'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]

  get '/profile', to: 'users#show', as: :profile
  namespace :profile do
    resources :orders, only: [:index]
  end

  namespace :dashboard do
    get '/', to: 'dashboard#index'
    resources :items, only: [:index]
  end

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only: [:index, :show]
    resources :merchants, only: [:show]
  end
end

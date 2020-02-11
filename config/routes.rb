Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
  end 
  
  resources :posts, only: [:new, :create, :destroy]
  resources :toppages, only: [:index]
  resources :likes, only: [:create, :destroy]
  resources :seclikes, only: [:create, :destroy]
  resources :battles, only: [:new, :create]
end

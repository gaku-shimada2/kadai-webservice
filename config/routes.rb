Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'  
  get 'signup', to: 'users#new'
  get 'complete', to: 'purchases#complete'
  get 'confirm', to: 'purchases#confirm'

  resources :users, only: [:show, :create, :edit, :update] do
    member do
      get :purchases
      get :likes
    end
  end
  resources :products, only: [:show]
  resources :purchases, only: [:create]
  resources :likes,only: [:create, :destroy]
end

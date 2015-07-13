Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: :signup
  get 'signin', to: 'user_sessions#new', as: :signin
  get 'signout', to: 'user_sessions#destroy', as: :signout

  resources :subcreddits, path: 'c', except: [:destroy]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  root to: 'subcreddits#index'
end

Rails.application.routes.draw do
  resources :tests, only: [:index, :show]

  get 'signup', to: 'users#new', as: :signup
  get 'signin', to: 'user_sessions#new', as: :signin
  get 'signout', to: 'user_sessions#destroy', as: :signout

  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:new, :create, :destroy]

  root to: 'tests#index'
end

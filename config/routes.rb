Rails.application.routes.draw do
  root 'home#show'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'home#show'
  get 'signout', to: 'sessions#destroy', as: "signout"

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]

  resources :microposts
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root 'welcome#index'
  #root 'home#show'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'home#show'
  get 'signout', to: 'sessions#destroy', as: "signout"

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

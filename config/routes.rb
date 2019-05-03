Rails.application.routes.draw do
  get 'comments/create'

  get 'comments/destroy'


  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :posts
  # nested routing(중첩 라우팅)
  resources :bulletins do
    resources :posts
  end

  root 'welcome#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'welcome#index'
  post 'signout', to: 'sessions#destroy', as: "signout"

  resources :login, only: [:index, :login]

  resources :sessions, only: [:create, :destroy]

  controller :uad do
    post '/member', action: :index
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root 'welcome#index'

  resources :posts
  # nested routing(중첩 라우팅)
  resources :bulletins do
    resources :posts
  end


  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'welcome#index'
  post 'signout', to: 'sessions#destroy', as: "signout"

  resources :sessions, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

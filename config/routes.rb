Rails.application.routes.draw do
  get 'loginform', to: 'users#login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  resources :users, only:%i[create new edit update]
  resources :articles
  resources :comments, only:%i[create destroy]
end

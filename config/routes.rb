Rails.application.routes.draw do
  get 'loginform', to: 'users#login'
  post 'login', to: 'sessions#create'
  post 'gestlogin', to: 'sessions#gestLogin'
  delete 'logout', to: 'sessions#destroy'
  get 'users/:id/articles', to: 'users#articles'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
  resources :users, only:%i[create new edit update destroy index]
  resources :articles
  resources :comments, only:%i[create destroy]
end

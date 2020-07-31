Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "articles/index" => "articles#index"
  get "articles/new" => "articles#new"
  post "articles/create" => "articles#create"
  get "articles/:id" => "articles#show"
  get "articles/:id/edit" => "articles#edit"
  post "articles/:id/update" => "articles#update"
  post "articles/:id/destroy" => "articles#destroy"
end

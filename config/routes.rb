Rails.application.routes.draw do
  # devise_for :users, controllers: { 
  #   registrations: 'users/registrations',
  #   sessions: "users/sessions" }

  root 'welcome#index'
  
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get "/dashboard" => "links#manage"
  get "/signup" => "users#new"
  post "/users" => "users#create"

  resources :links
  
  get ":slug" => "links#show"

  get "*unmatched_route", to: "application#no_route_found"
end

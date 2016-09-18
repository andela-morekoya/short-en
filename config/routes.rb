Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: "users/sessions" }

  root 'welcome#index'

  get "/dashboard" => "links#manage"

  resources :users 

  resources :links
  
  get ":slug" => "links#show"

  get "*unmatched_route", to: "application#no_route_found"
end

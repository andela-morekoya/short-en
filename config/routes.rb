Rails.application.routes.draw do
  root "welcome#index"

  get "/login"     => "sessions#new"
  post "/login"    => "sessions#create"
  get "/logout"    => "sessions#destroy"
  get "/dashboard" => "links#index"
  get "/signup"    => "users#new"
  post "/users"    => "users#create"

  resources :links

  get ":slug" => "links#show"

  get "*unmatched_route", to: "application#error"
end

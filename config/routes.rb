Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #
  # http://guides.rubyonrails.org/routing.html

  root "home#index"

  # For uploading files
  resources :blobs
  get "/upload", to: "blobs#new"

  # For omniauth
  match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]
  match "/auth/failure", to: "sessions#failure", via: [:get, :post]
  resources :identities
  get "/logout", to: "sessions#destroy", :as => "logout"
  get "/login", to: "sessions#new", :as => "login"
end

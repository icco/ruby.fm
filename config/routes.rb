Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #
  # http://guides.rubyonrails.org/routing.html

  root "home#index"

  # For uploading files
  resources :tracks
  get "/upload", to: "tracks#new"

  # Authentication
  devise_for :users
  get "/login", to: redirect("/users/sign_in")
end

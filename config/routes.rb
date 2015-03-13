Rails.application.routes.draw do
  root "home#index"

  # Authentication
  devise_for :users
  get "/login", to: redirect("/users/sign_in")

  namespace :my do
    resources :channels, only: [:index]
    resources :episodes, only: [:index]
  end

  resources :channels do
    resources :episodes, only: [:new, :create], controller: 'channels/episodes'
  end
  resources :episodes

  get '/:channel_id',     to: 'channels#show',          as: :slugged_channel
  get '/:channel_id/:id', to: 'channels/episodes#show', as: :slugged_channel_episode

  get "/upload", to: "tracks#new"
end

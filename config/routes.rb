Rails.application.routes.draw do
  # authenticated :user do
  #   root to: redirect("/my/episodes"), :as => :authenticated_root
  # end
  root "home#index"

  # Authentication
  devise_for :users, controllers: { registrations: 'registrations' }

  get "/login", to: redirect("/users/sign_in")
  get "/users/login", to: redirect("/users/sign_in")
  get "/about", to: "home#about"

  resources :channels, path: '', except: [:new, :create] do
    resources :episodes, path: '', only: [:new, :create], controller: 'channels/episodes'
  end
  resources :episodes

  get '/:id',             to: 'channels#show',          as: :slugged_channel
  get '/:channel_id/:id', to: 'channels/episodes#show', as: :slugged_channel_episode
end

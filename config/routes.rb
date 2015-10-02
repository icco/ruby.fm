Rails.application.routes.draw do
  root "home#index"

  # Authentication
  devise_for :users, controllers: { registrations: 'registrations' }

  get "/login", to: redirect("/users/sign_in")
  get "/users/login", to: redirect("/users/sign_in")
  get "/about", to: "home#about"

  # TODO make something intelligent
  get "/itunes", to: "channels#itunes"

  resources :channels, path: '', except: [:new, :create] do
    resources :episodes, path: '', only: [:new, :create], controller: 'channels/episodes'
  end
  resources :episodes, only: [:index, :edit, :update]

  get '/:id',             to: 'channels#show',          as: :slugged_channel
  get '/:channel_id/:id', to: 'channels/episodes#show', as: :slugged_channel_episode
end

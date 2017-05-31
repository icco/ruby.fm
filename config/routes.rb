Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  root "home#index"

  # Authentication
  devise_for :users, controllers: { registrations: 'registrations', sessions: "sessions" }

  get "/login", to: redirect("/users/sign_in")
  get "/users/login", to: redirect("/users/sign_in")
  get "/about", to: "home#about"
  get "/terms", to: "home#terms"

  resource :subscription, only: [:edit, :update]

  # TODO make something intelligent
  get "/itunes", to: "channels#itunes"
  get "/stats", to: "stats#index"
  get "/stats/overall", to: "stats#overall"
  get "/sitemap", to: redirect("https://rubyfm-blobs.s3.amazonaws.com/sitemaps/sitemap.xml.gz")

  resources :episodes, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :download
      get :play
      get :image
      get :card
    end
  end

  resources :channels, path: '', except: [:new, :create] do
    resources :episodes, path: '', only: [:new, :create], controller: 'channels/episodes'
  end

  get '/:id',             to: 'channels#show',          as: :slugged_channel
  get '/:channel_id/:id', to: 'channels/episodes#show', as: :slugged_channel_episode
end

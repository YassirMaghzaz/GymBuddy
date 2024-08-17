Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "pages#home"
  get "notice", to: "pages#notice"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "request", to: "pages#inv"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :matches, only: [ :index]
  resources :profiles do
    resources :objectives, only: [:new, :create]
    resources :preferences, only: [:new, :create]
    resources :gyms, only: [:new, :create]
    resources :matches, only: [ :create, :destroy] do
      collection do
        get :pending
        get :buddies
      end

      member do
        patch :accept
        patch :reject
      end
    end
  end
end

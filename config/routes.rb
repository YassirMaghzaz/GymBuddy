Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: "pages#home"
  get "notice", to: "pages#notice", as: :notice_path
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Routes pour la création, affichage, édition et mise à jour des profils
  resources :profiles, only: [:new, :create, :show, :edit, :update] do
    resources :objectifs, only: [:new, :create, :edit, :update, :destroy]
    resources :preferences, only: [:new, :create, :edit, :update, :destroy]
  end

  # Routes pour les gyms
  resources :gyms

  # Routes pour les utilisateurs avec actions de like et dislike
  # resources :users, only: [:index] do
  #   member do
  #     post 'like', to: 'matches#create', defaults: { status: 'accepted' }
  #     post 'dislike', to: 'matches#create', defaults: { status: 'rejected' }
  #   end
  # end
  resources :users, only: [:index] do
    member do
      post 'like'
      post 'dislike'
    end
  end
end

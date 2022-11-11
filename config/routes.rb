Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :reviews, only: [:index, :new, :create, :destroy]

  resources :routes, only: [:show, :index] do
    # agrego las rutas de favorites dentro de routes
    resources :favorites, only: [:show, :create]
  end
  resources :favorites, only: [:destroy, :index]
  resources :stop_stations, only: :index
  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :reviews, only: [:index, :new, :create, :delete]

  resources :routes, only: [:show, :index] do
    resources :stop_stations, only: :index
    # agrego las rutas de favorites dentro de routes
    resources :favorites, only: [:show, :create]
  end
  resources :favorites, only: [:delete, :index]
  # Defines the root path route ("/")
  # root "articles#index"
end

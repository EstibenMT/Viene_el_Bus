Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :reviews, only: [:index, :new, :create, :delete]

  resources :routes, only: :index
  resources :stop_stations, only: :index
  # Defines the root path route ("/")
  # root "articles#index"
end

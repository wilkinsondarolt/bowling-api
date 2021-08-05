Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    resources :deliveries, only: [:create], module: :games
  end
end

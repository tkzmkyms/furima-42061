Rails.application.routes.draw do
  devise_for :users
  
  resources :products, only: [:index, :new, :create]

  get "up" => "rails/health#show", as: :rails_health_check

  root "products#index"
end


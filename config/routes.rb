Rails.application.routes.draw do
  devise_for :users
  
  resources :products, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  root "products#index"
end


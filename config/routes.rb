Rails.application.routes.draw do
  devise_for :users
  
  resources :products, only: [:index, :new, :create, :show, :edit]

  root "products#index"
end


Rails.application.routes.draw do
  resources :gyms
  resources :clients, only: [:index, :show, :update]
  resources :memberships, only: [:index, :create]
end

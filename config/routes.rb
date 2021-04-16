Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :genres, only: %i[index show]
  resources :books, only: %i[index show]
  resources :cart, only: %i[index create destroy]
  root to: "books#index"
end

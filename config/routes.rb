Rails.application.routes.draw do
  get 'order/index'
  get 'order/show'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :genres, only: %i[index show]
  resources :books, only: %i[index show search list_new list_recent_update] do
    collection do
      get :search, :list_new, :list_recent_update
    end
  end
  resources :cart, only: %i[index create destroy update]

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  root to: "books#index"
end

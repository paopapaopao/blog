Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  # allow only logged in users to access the articles and comments paths
  authenticate :user do
    root to: 'articles#index'

    resources :articles do
      resources :comments, only: [:create, :destroy]
      resources :tags, only: [:create]
    end
  end
end

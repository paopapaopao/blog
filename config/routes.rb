Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#home'

  # devise_for :users

  # allow only logged in users to access the articles and comments paths
  authenticate :user do
    resources :articles do
      resources :comments
    end
  end

  # allow only logged in users with attribute admin set to true to access the admin path
  authenticate :user, lambda { |u| u.admin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end

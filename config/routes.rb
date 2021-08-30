Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#home'

  devise_for :users

  # allow only logged in users to access the articles and comments paths
  devise_scope :user do
    authenticated :user do
      namespace :users do
        resources :articles do
          resources :comments
        end
      end
    end
  end

  # allow only users with attribute admin set to true to access the admin page
  authenticate :user, lambda { |u| u.admin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end

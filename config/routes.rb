Rails.application.routes.draw do
  resources :articles do
    resources :comments
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/articles' => 'articles#index'
  get '/articles/new' => 'articles#new'#, as: 'new_article'
  post '/articles' => 'articles#create'#, as: 'create_article'
  root to: 'articles#index'
end

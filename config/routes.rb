Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get 'pages/home', to: 'pages#home'
  get '/terms', to: 'pages#terms'
  get '/privacy', to: 'pages#privacy'

  resources :recipes do
    resources :comments, only: [:create]
    member do
      post 'like'
    end
  end

  get '/recipes_by_likes', to: 'recipes#index_by_likes'
  get '/recipes_by_chefs', to: 'recipes#index_by_chefs'

  get 'signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :ingredients

  get '/chat', to: 'chatrooms#show'

  resources :messages, only: [:create]

  mount ActionCable.server => '/cable'

end

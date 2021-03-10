Rails.application.routes.draw do
  root 'sessions#home'
  
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/dashboard', to: 'dashboard#show'
  
  resources :users, except: [:new, :update, :index]
  resources :activities
  resources :roles do 
    resources :volunteers, only: [:index]
  end
  resources :volunteers do
    resources :activities, only: [:new, :create, :index] 
  end
end

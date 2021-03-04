Rails.application.routes.draw do
  root 'sessions#home'
  
  #Users & Sessions
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  resources :users, only: [:show, :index, :delete]
end

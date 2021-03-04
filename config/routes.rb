Rails.application.routes.draw do
  resources :activities
  resources :roles
  resources :volunteers
  root 'sessions#home'
  
  #Users & Sessions
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  resources :users, except: [:new, :update]
end

Rails.application.routes.draw do
  get 'dashboard', to: 'dashboard#show'
  root 'sessions#home'
  
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  resources :users, except: [:new, :update]
  resources :activities
  resources :roles do 
    resources :volunteers, only: [:index]#, controller: 'role_volunteers'
  end
  resources :volunteers do
    resources :activities, only: [:new, :create, :index] 
  end
end

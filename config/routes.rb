Rails.application.routes.draw do
  resources :users
  get '/login' => 'sessions#new'
  get '/auth/github/callback' => 'sessions#omniauth'
end

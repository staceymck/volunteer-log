Rails.application.routes.draw do
  resources :users
  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
end

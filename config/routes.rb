Rails.application.routes.draw do
  get '/auth/:provider/callback' => 'sessions#omniauth'
end

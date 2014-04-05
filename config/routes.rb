Rails.application.routes.draw do
  # omniauth
  get '/auth/:provider/callback', :to => 'so_auth/user_sessions#create'
  get '/auth/failure', :to => 'so_auth/user_sessions#failure'

  # Custom logout
  post '/logout', :to => 'so_auth/user_sessions#destroy'
end

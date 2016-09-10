Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
  get '/users',           to: 'users#list'
  get '/users/:id',       to: 'users#show'
  get '/user',            to: 'users#show_current'
  post '/users',          to: 'users#create'

  get '/microposts/:user_id',     to: 'microposts#list'
  post '/microposts',             to: 'microposts#create'
  delete '/microposts/:post_id',  to: 'microposts#destroy'

  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  post '/follow/:followed_id',      to: 'relationships#create'
  delete '/unfollow/:followed_id',  to: 'relationships#destroy'

  get '/feed',    to: 'feed#show'
  
end

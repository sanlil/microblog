Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
  get '/users',           to: 'users#list'
  get '/users/:id',       to: 'users#show'
  post '/users',          to: 'users#create'

  get '/microposts',      to: 'microposts#list'
  get '/microposts/:id',  to: 'microposts#show'
  post '/microposts',     to: 'microposts#create'

  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  
end

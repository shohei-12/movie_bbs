Rails.application.routes.draw do
  root 'home#top'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/guest_login', to: 'sessions#guest'
  delete '/logout', to: 'sessions#destroy'
  post '/like/:post_id', to: 'likes#create', as: 'like'
  delete '/like/:post_id', to: 'likes#destroy', as: 'unlike'
  resources :users
  resources :posts
  resources :relationships, only: %i[create destroy]
end

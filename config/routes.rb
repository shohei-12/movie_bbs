Rails.application.routes.draw do
  root 'home#top'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/guest_login', to: 'sessions#guest'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :posts
end

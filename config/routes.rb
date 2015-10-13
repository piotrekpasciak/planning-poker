Rails.application.routes.draw do

  resources :session, only: [:new, :create]
  resources :poker_rooms, only: [:show, :create]

  root 'poker_rooms#new'
end

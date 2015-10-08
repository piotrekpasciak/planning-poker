Rails.application.routes.draw do
  resources :poker_rooms, only: [:show, :create]


  root 'poker_rooms#new'
end

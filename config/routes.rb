Rails.application.routes.draw do
  resources :poker_rooms, only: [:show, :create]

  root 'page#home'
end

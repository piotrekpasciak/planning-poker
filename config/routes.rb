Rails.application.routes.draw do
  resources :poker_rooms, only: [:show, :create] do
    resources :session, only: [:new, :create]
  end

  root 'poker_rooms#new'
end

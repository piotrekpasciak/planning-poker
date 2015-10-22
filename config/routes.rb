Rails.application.routes.draw do

  resources :poker_rooms, only: [:show, :create] do
    resources :session, only: [:new, :create]
    resources :summaries, only: [:index, :create]
  end

  root 'poker_rooms#new'
end

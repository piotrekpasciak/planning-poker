Rails.application.routes.draw do

  resources :poker_rooms, only: [:show, :create] do
    resources :session, only: [:new, :create]
    resources :summaries, only: [:index, :create]
    post '/send_email', to: 'summaries#send_email'
  end

  root 'poker_rooms#new'
end

Rails.application.routes.draw do
  resources :message_groups
  resources :messages
  resources :blockeds
  root 'home#index'
  resources :friendships, only: %i[index new destroy] do
    get 'header', on: :collection
    delete 'remove', on: :collection, to: 'friendships#destroy'
  end

  resources :users do
    patch '/set_status', to: 'users#set_status'
  end
  
  resources :available_friendships, only: %i[index]

  resources :friendship_requests do
    post 'accept', on: :member
  end

  resources :chatrooms do
    get 'direct', on: :collection
  end

  namespace :sessions do
    resources :signin, only: %i[new create]
    resources :signup, only: %i[new create]
    delete '/signout', to: 'signout#destroy'
  end

end

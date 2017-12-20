Rails.application.routes.draw do
  resources :messages
  resources :users
  mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      resources :chats
      post '/login', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/message/', to: 'message#create'
  put '/message/', to: 'message#update'
  get '/message/:id/(:local)', to: 'message#show'
  get '/messages/(:local)', to: 'message#index'


  post '/notification/', to: 'notification#sendOneNotification'
end

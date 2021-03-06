Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post'/message/', to: 'message#create'
      put '/message/', to: 'message#update'
      get '/message/:id/(:local)', to: 'message#show'
      get '/messages/(:local)', to: 'message#index'


      post '/notification/', to: 'notification#sendNotification'
      post '/notification_group/', to: 'notification#sendGroupNotification'
    end
  end
end

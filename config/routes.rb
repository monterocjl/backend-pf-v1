Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post '/login' => 'sessions#create'
      get '/logout' => 'sessions#destroy'
      post '/signup' => 'users#create'

      resource :profile, except: %i[index create], controller: :users
      
      resources :tables do
        resources :operations
        resources :operation_categories
      end
    end
  end
end
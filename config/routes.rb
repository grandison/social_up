SocialUp::Application.routes.draw do

  resources :alarms, only: [:index, :show] do
    resources :music_sets, only: [:create] do |collection|
      post :like
    end
    collection do
      get :friends
    end
  end
  
  resources :users_search, only: [ :index ]
  
  namespace :api do
    namespace :v1 do
      resources :tokens, only: [:show]
      resources :users, only: [:update, :index]
    end
  end

  root to: "alarms#friends"
end

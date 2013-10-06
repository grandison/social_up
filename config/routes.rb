SocialUp::Application.routes.draw do
  resources :users, only: [:update] do
    collection do
      get 'fetch_data'
    end
  end
  resources :alarms, only: [:index, :show, :create] do
    resources :music_sets, only: [:create] do |collection|
      post :like
    end
    collection do
      get :friends
    end
  end
  
  resources :users_search, only: [ :index ] do
    get :render_user, on: :collection
  end
  
  namespace :api do
    namespace :v1 do
      resources :tokens, only: [:show]
      resources :users, only: [:update, :index]
    end
  end

  root to: "alarms#friends"
end

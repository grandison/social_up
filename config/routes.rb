SocialUp::Application.routes.draw do

  resources :alarms, only: [:index, :show] do
    resources :music_sets, only: [:create] do |collection|
      post :like
    end
    collection do
      get :friends
    end
  end
  
  root to: "alarms#friends"
end

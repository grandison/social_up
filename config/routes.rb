SocialUp::Application.routes.draw do
  root to: "alarms#friends"
  resources :alarms, only: [:index] do
    collection do
      get :friends
    end
  end
end

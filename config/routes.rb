SocialUp::Application.routes.draw do
  resources :alarms, only: [:index] do
    collection do
      get :friends
    end
  end
  root to: "alarms#friends"
end

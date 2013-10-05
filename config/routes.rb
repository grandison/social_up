SocialUp::Application.routes.draw do
  resources :alarms, only: [:index, :show] do
    collection do
      get :friends
    end
  end
  root to: "alarms#friends"
end

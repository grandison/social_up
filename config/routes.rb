SocialUp::Application.routes.draw do
  root to: "dashboard#show"
  resources :alarms, only: [:index] do
    collection do
      get :friends
    end
  end
end

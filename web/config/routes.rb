Rails.application.routes.draw do
  root to: "homes#index"

  get "/login", to: "okta_login#index"

  get "/auth/google_oauth2/callback", to: "okta_login#login"

  resources :whiteboards do
    resources :helps
    resources :new_faces
    resources :interestings
    resources :events
    resources :standup_email_configs

    resources :standups, module: :standups do
      resources :new_faces
      resources :helps
      resources :interestings
      resources :events
      resources :archives
      resources :emails
    end
  end

end

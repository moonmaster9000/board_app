Rails.application.routes.draw do
  root to: "homes#index"

  resources :whiteboards do
    resources :helps
    resources :new_faces
    resources :interestings
    resources :events

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

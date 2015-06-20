Rails.application.routes.draw do
  root to: "homes#index"

  resources :whiteboards do
    resources :helps
    resources :new_faces
    resources :interestings
    resources :events
  end

  resources :standups do
    resources :archives
  end
end

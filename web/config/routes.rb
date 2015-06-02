Rails.application.routes.draw do
  root to: "homes#index"

  resources :whiteboards do
    resources :helps
    resources :new_faces
  end
end

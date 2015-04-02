Rails.application.routes.draw do
  root to: "homes#index"

  resources :teams do
    resources :helps
    resources :new_faces
  end
end

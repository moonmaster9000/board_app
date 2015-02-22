Rails.application.routes.draw do
  root to: "homes#index"

  resources :teams do
    resources :new_faces
  end
end

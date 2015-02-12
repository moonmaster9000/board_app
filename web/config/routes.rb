Rails.application.routes.draw do
  root to: "homes#index"

  resources :standups do
    resources :new_faces
  end
end

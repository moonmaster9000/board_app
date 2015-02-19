Rails.application.routes.draw do

  mount Persistence::Engine => "/persistence"
end

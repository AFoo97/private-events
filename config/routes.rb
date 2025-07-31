Rails.application.routes.draw do
  get "users/show"
  get "event_attendances/create"
  get "event_attendances/destroy"
  get "events/index"
  get "events/new"
  get "events/create"
  get "events/show"
  get "events/edit"
  get "events/update"
  get "events/destroy"
  
  devise_for :users
  root "events#index"

  resources :events
  resources :users, only: [:show]

  post "/event_attendances", to: "event_attendances#create"
  delete "/event_attendances", to: "event_attendances#destroy"
end

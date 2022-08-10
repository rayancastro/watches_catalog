Rails.application.routes.draw do
  resources :watches, only: [:index]
end

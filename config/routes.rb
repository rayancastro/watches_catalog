Rails.application.routes.draw do
  root to: 'watches#index'
  resources :watches, only: [:index]

  resources :orders, only: [] do
    post :checkout, on: :collection
  end
end

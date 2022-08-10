Rails.application.routes.draw do
  resources :watches, only: [:index]

  resources :orders, only: [] do
    post :checkout, on: :collection
  end
end

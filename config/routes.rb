Rails.application.routes.draw do
  root to: 'watches#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :watches, only: [:index]

      resources :orders, only: [] do
        post :checkout, on: :collection
      end
    end
  end
end

Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json} do
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
    end
  end
end

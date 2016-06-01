Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json} do
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :invoices, only: [:index]
      resources :invoice_items, only: [:index]
    end
  end
end

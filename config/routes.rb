Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json} do
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index]
      resources :transactions, only: [:index, :show]
    end
  end
end

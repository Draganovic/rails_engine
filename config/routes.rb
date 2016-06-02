Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json} do
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]

      get "/customers/find", to: "customers/finders#show"
      get "/customers/find", to: "customers/finders#index"

      get "/invoices/find", to: "invoices/finders#show"
      get "/invoices/find", to: "invoices/finders#index"

      get "/invoice_items/find", to: "invoice_items/finders#show"
      get "/invoice_items/find", to: "invoice_items/finders#index"

      get "/items/find", to: "items/finders#show"
      get "/items/find", to: "items/finders#index"

      get "/merchants/find", to: "merchants/finders#show"
      get "/merchants/find", to: "merchants/finders#index"

      get "/transactions/find", to: "transactions/finders#show"
      get "/transactions/find", to: "transactions/finders#index"


    end
  end
end

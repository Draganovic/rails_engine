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
      get "/customers/random", to: "customers/random#show"

      get "/invoices/find", to: "invoices/finders#show"
      get "/invoices/find", to: "invoices/finders#index"
      get "/invoices/random", to: "invoices/random#show"
      get "/invoices/:id/transactions", to: "invoices/transactions#index"
      get "/invoices/:id/invoice_items", to: "invoices/invoice_items#index"
      get "/invoices/:id/items", to: "invoices/items#index"
      get "/invoices/:id/customer", to: "invoices/customers#show"
      

      get "/invoice_items/find", to: "invoice_items/finders#show"
      get "/invoice_items/find", to: "invoice_items/finders#index"
      get "/invoice_items/random", to: "invoice_items/random#show"

      get "/items/find", to: "items/finders#show"
      get "/items/find", to: "items/finders#index"
      get "/items/random", to: "items/random#show"

      get "/merchants/find", to: "merchants/finders#show"
      get "/merchants/find", to: "merchants/finders#index"
      get "/merchants/random", to: "merchants/random#show"
      get "/merchants/:id/items", to: "merchants/items#index"
      get "/merchants/:id/invoices", to: "merchants/invoices#index"

      get "/transactions/find", to: "transactions/finders#show"
      get "/transactions/find", to: "transactions/finders#index"
      get "/transactions/random", to: "transactions/random#show"

    end
  end
end

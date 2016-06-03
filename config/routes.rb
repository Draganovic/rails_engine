Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json } do

      get "/customers/find", to: "customers/finders#show"
      get "/customers/find_all", to: "customers/finders#index"
      get "/customers/random", to: "customers/random#show"
      get "/customers/:id/invoices", to: "customers/invoices#index"
      get "/customers/:id/transactions", to: "customers/transactions#index"
      resources :customers, only: [:index, :show]

      get "/invoices/find", to: "invoices/finders#show"
      get "/invoices/find_all", to: "invoices/finders#index"
      get "/invoices/random", to: "invoices/random#show"
      get "/invoices/:id/transactions", to: "invoices/transactions#index"
      get "/invoices/:id/invoice_items", to: "invoices/invoice_items#index"
      get "/invoices/:id/items", to: "invoices/items#index"
      get "/invoices/:id/customer", to: "invoices/customers#show"
      get "/invoices/:id/merchant", to: "invoices/merchants#show"
      resources :invoices, only: [:index, :show]

      get "/invoice_items/find", to: "invoice_items/finders#show"
      get "/invoice_items/find_all", to: "invoice_items/finders#index"
      get "/invoice_items/random", to: "invoice_items/random#show"
      resources :invoice_items, only: [:index, :show]
      get "/invoice_items/:id/invoice", to: "invoice_items/invoices#show"
      get "/invoice_items/:id/item", to: "invoice_items/items#show"

      get "/items/find", to: "items/finders#show"
      get "/items/find_all", to: "items/finders#index"
      get "/items/random", to: "items/random#show"
      get "/items/:id/invoice_items", to: "items/invoice_items#index"
      get "/items/:id/merchant", to: "items/merchants#show"
      resources :items, only: [:index, :show, :create, :update, :destroy]

      get "/merchants/find", to: "merchants/finders#show"
      get "/merchants/find_all", to: "merchants/finders#index"
      get "/merchants/random", to: "merchants/random#show"
      get "/merchants/:id/items", to: "merchants/items#index"
      get "/merchants/:id/invoices", to: "merchants/invoices#index"
      get "merchants/:id/customers_with_pending_invoices", to: "merchants/pending_invoices#index"
      get "merchants/:id/favorite_customer", to: "merchants/favorite_customer#show"
      resources :merchants, only: [:index, :show]

      get "/transactions/find", to: "transactions/finders#show"
      get "/transactions/find_all", to: "transactions/finders#index"
      get "/transactions/random", to: "transactions/random#show"
      get "/transactions/:id/invoice", to: "transactions/invoices#show"

      resources :transactions, only: [:index, :show]
    end
  end
end

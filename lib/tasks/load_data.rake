require 'csv'

namespace :csv do
  desc "load csv files to db"
  task load_to_db: :environment do
    CSV.foreach("data/customers.csv", headers: true) do |row|
      Customer.create(
        :first_name => row["first_name"],
        :last_name => row["last_name"],
        :created_at => row["created_at"],
        :updated_at => row["updated_at"]
      )
    end
    CSV.foreach("data/merchants.csv", headers: true) do |row|
      Merchant.create(
      :name => row["name"],
      :created_at => row["created_at"],
      :updated_at => row["updated_at"]
      )
    end
    CSV.foreach("data/items.csv", headers: true) do |row|
      Item.create(
      :name => row["name"],
      :description => row["description"],
      :unit_price => row["unit_price"],
      :merchant_id => row["merchant_id"],
      :created_at => row["created_at"],
      :updated_at => row["updated_at"]
      )
    end
    CSV.foreach("data/invoices.csv", headers: true) do |row|
      Invoice.create(
      :status => row["status"],
      :customer_id => row["customer_id"],
      :merchant_id => row["merchant_id"],
      :created_at => row["created_at"],
      :updated_at => row["updated_at"]
      )
    end
    CSV.foreach("data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create(
        :quantity => row["quantity"],
        :unit_price => row["unit_price"],
        :item_id => row["item_id"],
        :invoice_id => row["invoice_id"],
        :created_at => row["created_at"],
        :updated_at => row["updated_at"]
      )
    end
    CSV.foreach("data/transactions.csv", headers: true) do |row|
      Transaction.create(
        :credit_card_number => row["credit_card_number"],
        :result => row["result"],
        :invoice_id => row["invoice_id"],
        :created_at => row["created_at"],
        :updated_at => row["updated_at"]
      )
    end
  end
end

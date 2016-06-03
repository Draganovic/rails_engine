require "rails_helper"

RSpec.describe Api::V1::Items::HighestSalesDateController do
  before(:each) do
    @item = Item.create(name: "bouncy ball")

    merchant = Merchant.create(name:"bob-jones")

    invoice1 = Invoice.create(created_at: Date.today)
    invoice2 = Invoice.create(created_at: Date.today + 2 )
    invoice3 = Invoice.create(created_at: Date.today + 2 )
    invoice4 = Invoice.create(created_at: Date.today + 1 )

    invoice_item1 = InvoiceItem.create(item_id: @item.id, invoice_id: invoice1.id, quantity: 2)
    invoice_item2 = InvoiceItem.create(item_id: @item.id, invoice_id: invoice2.id, quantity: 2)
    invoice_item3 = InvoiceItem.create(item_id: @item.id, invoice_id: invoice3.id, quantity: 2)
    invoice_item4 = InvoiceItem.create(item_id: @item.id, invoice_id: invoice4.id, quantity: 2)

    Transaction.create(invoice_id: invoice1.id, result: "success")
    Transaction.create(invoice_id: invoice2.id, result: "success")
    Transaction.create(invoice_id: invoice3.id, result: "success")
    Transaction.create(invoice_id: invoice4.id, result: "success")
  end

  describe "Get show" do
    it "shows the date that the most sales of an item occured" do
      date = Date.today +2
      get :show, id: @item.id, format: :json
      item_date_hash = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item_date_hash).to eq date: date
    end
  end
end

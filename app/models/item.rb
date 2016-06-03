class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def random
    num = rand(Item.count)
    Item.offset(num).first
  end

  def best_day
    invoice_items.joins(:transactions).where("transactions.result = 'success'")
     .order(quantity: :desc).take(2)
     .first.invoice.created_at
  end

end

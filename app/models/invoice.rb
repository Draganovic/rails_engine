class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def random
    num = rand(Invoice.count)
    Invoice.offset(num).first
  end
end

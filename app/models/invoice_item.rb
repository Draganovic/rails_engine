class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  def random
    num = rand(InvoiceItem.count)
    InvoiceItem.offset(num).first
  end

end

class InvoiceItem < ActiveRecord::Base

  def random
    num = rand(InvoiceItem.count)
    InvoiceItem.offset(num).first
  end

end

class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant

  def random
    num = rand(Invoice.count)
    Invoice.offset(num).first
  end
end

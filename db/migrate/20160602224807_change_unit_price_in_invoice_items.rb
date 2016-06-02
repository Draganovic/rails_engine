class ChangeUnitPriceInInvoiceItems < ActiveRecord::Migration
    def up
      change_column :invoice_items, :unit_price, :integer
    end

    def down
      change_column :invoice_items, :unit_price, :decimal
    end
end

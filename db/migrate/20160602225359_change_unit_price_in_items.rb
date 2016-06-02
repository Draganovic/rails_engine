class ChangeUnitPriceInItems < ActiveRecord::Migration
  def up
    change_column :items, :unit_price, :integer
  end

  def down
    change_column :items, :unit_price, :decimal
  end
end

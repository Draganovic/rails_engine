class RemoveMerchantIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :merchant_id, :integer
  end
end

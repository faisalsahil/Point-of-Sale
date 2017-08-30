class AddExpiryToPurchaseOrderProducts < ActiveRecord::Migration
  def change
    add_column :purchase_order_products, :expiry_date, :date
  end
end

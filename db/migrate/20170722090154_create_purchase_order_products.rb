class CreatePurchaseOrderProducts < ActiveRecord::Migration
  def change
    create_table :purchase_order_products do |t|
      t.integer :purchase_order_id
      t.integer :current_stock
      t.integer :purchase_quantity

      t.timestamps
    end
  end
end

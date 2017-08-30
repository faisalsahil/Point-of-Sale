class AddNameToPurchaseOrderProducts < ActiveRecord::Migration
  def change
    add_column :purchase_order_products, :name, :string
    add_column :purchase_order_products, :product_id, :integer
  end
end

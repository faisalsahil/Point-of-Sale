class AddColumnToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :product_name, :string
    add_column :order_products, :purchase_price, :integer
  end
end

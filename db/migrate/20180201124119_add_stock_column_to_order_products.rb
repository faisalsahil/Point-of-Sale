class AddStockColumnToOrderProducts < ActiveRecord::Migration
  def change
    add_column :order_products, :product_stock, :string
  end
end

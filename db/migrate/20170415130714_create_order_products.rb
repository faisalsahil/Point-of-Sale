class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :product_id
      t.float :unit_cost
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end

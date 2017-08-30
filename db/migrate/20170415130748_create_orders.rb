class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      # t.string :order_number , auto_increment: true
      t.string :customer_name
      t.timestamps
    end
  end
end

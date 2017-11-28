class AddColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :purchase_order_id, :integer
  end
end

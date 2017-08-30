class AddIsCompletedToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :is_completed, :boolean, default: false
  end
end

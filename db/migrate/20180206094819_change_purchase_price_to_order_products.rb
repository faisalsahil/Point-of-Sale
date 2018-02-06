class ChangePurchasePriceToOrderProducts < ActiveRecord::Migration
  def change
      change_column :order_products, :purchase_price, :float
  end
end

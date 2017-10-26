class AddBarcodeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :barcode, :string , unique: true
  end
end

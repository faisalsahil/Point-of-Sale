class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :product_name
      t.string  :product_image
      t.integer :quantity
      t.float   :purchase_price,        default: 0.0
      t.float   :sale_price,            default: 0.0
      t.float   :purchase_margin,       default: 0.0
      t.text    :product_description
      t.date    :expiry_date
      
      # t.float   :sale_discount_percent, default: 0.0
      # t.float   :sale_discount_flat,    default: 0.0
      # t.boolean :is_sale_discount,     default: false
      # t.boolean :is_purchase_margin,   default: false
      

      t.timestamps
    end
  end
end

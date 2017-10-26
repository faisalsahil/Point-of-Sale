  class OrderProduct < ActiveRecord::Base
  
  belongs_to :order ,inverse_of: :order_products
  belongs_to :product

   after_save :remove_product

 before_destroy :add_product

 def remove_product

   product.quantity -= self.quantity
   product.save
 end

  def add_product
     product.quantity += self.quantity
     product.save
  end

  delegate :sale_price, :product_name, to: :product

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, presence: true
  validates :product_id, uniqueness: { scope: :order_id, message: "cannot reuse same product for this order" }

  def unit_price
    self.unit_cost || self.sale_price || 0
  end

  def total_price
    self.quantity * self.unit_price
  end

end
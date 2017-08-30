class PurchaseOrder < ActiveRecord::Base
  has_many :purchase_order_products
  
  validates :name, presence: true
end

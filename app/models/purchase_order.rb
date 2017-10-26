class PurchaseOrder < ActiveRecord::Base
  has_many :purchase_order_products

  belongs_to :product

  validates :name, presence: true


  accepts_nested_attributes_for :purchase_order_products, allow_destroy: true

end

class Order < ActiveRecord::Base

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  validates :order_id, uniqueness: true
  validates :discount, presence: true
  before_create :set_order_number

  belongs_to :product

  accepts_nested_attributes_for :order_products, allow_destroy: true

  def set_order_number
    last_order_number = Order.maximum(:id)
  end

end
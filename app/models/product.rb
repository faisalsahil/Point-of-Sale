class Product < ActiveRecord::Base

  has_many :order_products
  has_many :orders, through: :order_products

  validates :sale_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :product_name, presence: true

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
end

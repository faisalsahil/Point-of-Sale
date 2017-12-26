class Product < ActiveRecord::Base
  # mount_uploader :avatar, AvatarUploader
  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

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

require 'csv'

task import_items: :environment do
  csv_text = File.read('items.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    product                = Product.new
    product.product_name   = row['name']
    product.quantity       = row['quantity']
    product.purchase_price = row['price']
    product.sale_price     = row['price']
    product.expiry_date    = row['expiry_date']

    product.save!
  end
end
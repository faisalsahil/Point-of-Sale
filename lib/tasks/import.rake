require 'csv'
require 'barby'
require 'barby/outputter/png_outputter'
require 'barby/barcode/code_128'
require 'barby/outputter/ascii_outputter'

task import_items: :environment do
  csv_text = File.read('item.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    product                = Product.new
    product.product_name   = row['name']
    product.quantity       = row['quantity']
    product.purchase_price = row['price']
    product.sale_price     = row['price']
    product.expiry_date    = row['expiry_date']

    barcodeName = row['name']
    puts barcodeName.class

    product.barcode = barcodeName
    barcode1 =  Barby::Code128B.new(barcodeName)

    File.open( "app/assets/images/#{barcodeName}.png", 'w'){|f|
      f.write barcode1.to_png(:height => 20, :width => 20,  :margin => 5)
    }

  # binding.pry
    cloud_barcode_name = Cloudinary::Uploader.upload("app/assets/images/#{barcodeName}.png")
    product.avatar = "#{cloud_barcode_name["public_id"]}.png"

    File.delete("app/assets/images/#{barcodeName}.png") if File.exist?("app/assets/images/#{barcodeName}.png")

    product.save!

    puts "###########################"
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts product.product_name
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts "###########################"
  end
end
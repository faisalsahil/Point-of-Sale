class ProductsController < ApplicationController

   require 'barby'
   require 'barby/outputter/png_outputter'
   require 'barby/barcode/code_128'
   require 'barby/outputter/ascii_outputter'

  before_action :set_product, only: [:show, :edit, :update, :destroy,:print]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def print
#     @printer = Escpos::Printer.new
#
#     # image = Escpos::Image.new 'path/to/image.png'
# # to use automatic conversion to monochrome format (requires mini_magick gem) use:
#     image = Escpos::Image.new 'hamza.png',{
#         :size => '240x160'
#     }
#
#     # image = Escpos::Image.new 'hamza.png', {
#     #     convert_to_monochrome: true,
#     #     dither: true, # the default
#     #     extent: true, # the default
#     # }
#
#     @printer.write image.to_escpos
#
#     @printer.to_escpos # returns ESC/POS data ready to be sent to printer
# # on linux this can be piped directly to /dev/usb/lp0
# # with network printer sent directly to printer socket
# # with serial port printer it can be sent directly to the serial port
#     @printer.to_base64
#     # binding.pry
#

  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new

    # respond_with(@product, @product_natures)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    # barcode = SecureRandom.hex(10).upcase
    # barcode = 'TG22499'

    barcode = @product.product_name
    @product.barcode = barcode

    if @product.save
      barcode1 =  Barby::Code128B.new(barcode)
      name = @product.product_name
      File.open( "app/assets/images/barcodes/#{name}.png", 'w'){|f|
        f.write barcode1.to_png(:height => 24, :margin => 5)
      }
      #  File.print( name+".png",'w')
      respond_with(@product)

    end
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
     @product.destroy
    respond_with(@product)
  end
  
  def download
    @products = Product.all
    respond_to do |format|
      format.csv { send_data @products.to_csv }
    end
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:product_name, :product_image, :purchase_price, :sale_price, :product_description, :quantity, :expiry_date)
    end
end

class ProductsController < ApplicationController

   require 'barby'
   require 'barby/outputter/png_outputter'
   require 'barby/barcode/code_128'
   require 'barby/outputter/ascii_outputter'

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
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
      File.open( name+".png", 'w'){|f|
        f.write barcode1.to_png(:height => 20, :margin => 5)
      }
      respond_with(@product)
    else

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

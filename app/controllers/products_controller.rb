class ProductsController < ApplicationController

   require 'barby'
   require 'barby/outputter/png_outputter'
   require 'barby/barcode/code_128'
   require 'barby/outputter/ascii_outputter'

  before_action :set_product, only: [:show, :edit, :update, :destroy,:print]

  respond_to :html, :js

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    @purchase_orders = PurchaseOrder.all
    # respond_with(@product, @product_natures)
  end

  def edit
    @purchase_orders = PurchaseOrder.all
  end

  def create
    @product = Product.new(product_params)
    # barcode = SecureRandom.hex(10).upcase
    # barcode = 'TG22499'

    # barcode = @product.product_name
    # @product.barcode = barcode

      if @product.save
        # binding.pry
        if params[:purchase_order].present?
          purchase_order = PurchaseOrder.new
          purchase_order.name = params[:purchase_order]
          purchase_order.save

          redirect_to "/purchase_orders/#{purchase_order.id}/purchase_order_products/add?product_ids=#{@product.id}&purchase_order_id=#{purchase_order.id}&quantities=#{0}"
        else
          redirect_to "/purchase_orders/#{params[:product][:purchase_order_id]}/purchase_order_products/add?product_ids=#{@product.id}&purchase_order_id=#{params[:product][:purchase_order_id]}&quantities=#{0}"
        end

        # redirect_to products_path
      end

    # if @product.save

      # barcode1 =  Barby::Code128B.new(barcode)
      # name = @product.product_name
      # File.open( "app/assets/images/barcodes/#{name}.png", 'w'){|f|
      #   f.write barcode1.to_png(:height => 24, :margin => 5)
      # }
      #  File.print( name+".png",'w')
      # render js: "alert('Hello Rails');"
    #   respond_with(@product)
    #
    # end
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
      params.require(:product).permit(:product_name, :product_image, :purchase_price, :sale_price, :product_description, :quantity, :expiry_date, :purchase_order_id, :purchase_order)
    end
end

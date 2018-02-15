class ProductsController < ApplicationController
  load_and_authorize_resource

   require 'barby'
   require 'barby/outputter/png_outputter'
   require 'barby/barcode/code_128'
   require 'barby/outputter/ascii_outputter'

  before_action :set_product, only: [:show, :edit, :update, :destroy,:print]

  respond_to :html, :js

  def index
    @products = Product.select(:id, :product_name, :quantity, :purchase_price, :sale_price)
    @purchase_orders = PurchaseOrder.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    @purchase_orders = PurchaseOrder.all

  end

  def edit
    @purchase_orders = PurchaseOrder.all
  end

  def create
    @product = Product.new(product_params)

      barcodeName = @product.product_name
      @product.barcode = barcodeName

      barcode1 =  Barby::Code128B.new(barcodeName)

      File.open( "app/assets/images/#{barcodeName}.png", 'w'){|f|
        f.write barcode1.to_png
      }

      cloud_barcode_name = Cloudinary::Uploader.upload("app/assets/images/#{barcodeName}.png")
      @product.avatar = "#{cloud_barcode_name["public_id"]}.png"

      if @product.save
        File.delete("app/assets/images/#{barcodeName}.png") if File.exist?("app/assets/images/#{barcodeName}.png")

        if params[:purchase_order].present?
          purchase_order = PurchaseOrder.find_by(name: params[:purchase_order])
          if purchase_order.present?
            redirect_to "/purchase_orders/#{purchase_order.id}/purchase_order_products/add?product_ids=#{@product.id}&purchase_order_id=#{purchase_order.id}&quantities=#{0}"
          else
            purchase_order = PurchaseOrder.new
            purchase_order.name = params[:purchase_order]
            purchase_order.save

            redirect_to "/purchase_orders/#{purchase_order.id}/purchase_order_products/add?product_ids=#{@product.id}&purchase_order_id=#{purchase_order.id}&quantities=#{0}"
          end
        elsif params[:product][:purchase_order_id].present?
          redirect_to "/purchase_orders/#{params[:product][:purchase_order_id]}/purchase_order_products/add?product_ids=#{@product.id}&purchase_order_id=#{params[:product][:purchase_order_id]}&quantities=#{0}"
        else
          redirect_to products_path
        end

      end
  end

  def print

  end

  def update
    existing_quantity = @product.quantity
    @product.update(product_params)
    # binding.pry
    if params[:product][:update_quantity] == "1"
      @product.quantity = @product.quantity +  existing_quantity
    end
    @product.save

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

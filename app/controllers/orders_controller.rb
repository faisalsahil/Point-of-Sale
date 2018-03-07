class OrdersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  load_and_authorize_resource

  protect_from_forgery prepend: true, with: :exception

  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :load_locations_and_products, only: [:new, :edit, :update]

  respond_to :html

  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    respond_to do |format|
      format.html do
        respond_with(@order)
      end
      format.pdf do
        pdf_name = "#{@order.id}"
        render pdf: pdf_name,
               disposition: 'attachment',
               # template: templ,
               layout: 'pdf.html', # use 'pdf.html' for a pdf.html.erb file
               page_offset: 0,
               book: false,
               default_header: true,
               lowquality: false,
               # save_only:       true,
               margin: {bottom: 25, top: 25},
               header: {
                   html: {
                       template: '/shared/header.pdf.erb', # use :template OR :url
                       layout: 'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 14,
                   line: false
               }, # optionally you can pass plain html already rendered (useful if using pdf_from_string)
               footer: {
                   html: {
                       template: '/shared/footer.pdf.erb', # use :template OR :url
                       layout: 'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 14,
                   line: true
               }
      end
    end
  end

  def purchase_order
    @order = Order.new
  end
  
  def sale_order
    @order = Order.new
    @products = Product.where("quantity > ?", 0)
    @order_number = SecureRandom.hex(3).upcase
  end

  def edit
    @order_products = @order.order_products
  end

  def delete_product
    order_product = OrderProduct.find(params[:order_product_id])
    product = order_product.product
    product.quantity += order_product.quantity
    product.save
    order_product.destroy
    redirect_to orders_path
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to sale_order_orders_path

    else
      redirect_to sale_order_orders_path
      flash[:failure] = 'Discount needs to be Filled or by Default 0'
    end
  end

  def update
    if @order.update(order_params)
     respond_with(@order)
     flash[:Success] = 'Done'
    else
      flash[:failure] = 'Sorry'
    end
  end

  def destroy
    order_products = @order.order_products
    order_products.each do |order_product|
      product = order_product.product
      product.quantity += order_product.quantity
      product.save
    end

    if  @order.destroy
      redirect_to orders_path
    end
  end

  

  private
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(
        :order_id,
        :discount,
        order_products_attributes: [
        :id,
        :quantity,
        :product_id,
        :unit_cost,
        :product_name,
        :purchase_price
      ]
    )
  end

  def load_locations_and_products
    # @locations = Location.all
    @products = Product.all
  end
  respond_to do |format|
    format.html
  end
end
class OrdersController < ApplicationController
  skip_before_filter :verify_authenticity_token

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
        pdf_name = "#{@order.order_number}"
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
                       template: '/orders/header.pdf.erb', # use :template OR :url
                       layout: 'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 14,
                   line: false
               }, # optionally you can pass plain html already rendered (useful if using pdf_from_string)
               footer: {
                   html: {
                       template: '/orders/footer.pdf.erb', # use :template OR :url
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
    @products = Product.all
  end

  def edit
    @order_products = @order.order_products
  end

  def create
    @order = Order.new(order_params)
    @order.save
    
    flash[:success] = 'order created'
    redirect_to orders_path
  end

  def update
    @order.update(order_params)
    # respond_with(@order)
    flash[:success] = 'order Updated'
    redirect_to orders_path
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end
  
  def sale_report
    @orders = Order.where('created_at::date = ?', Date.today)
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(
      order_products_attributes: [
        :id,
        :quantity,
        :product_id,
        :unit_cost
      ]
    )
  end

  def load_locations_and_products
    # @locations = Location.all
    @products = Product.all
  end
end
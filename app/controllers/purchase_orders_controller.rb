class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]
  
  # respond_to :html
  
  def index
    @purchase_orders = PurchaseOrder.all
  end
  
  def show
    @purchase_order
    @purchase_order_products = @purchase_order.purchase_order_products
  end
  
  def new
    @purchase_order = PurchaseOrder.new
  end
  
  def edit
  end
  
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    if @purchase_order.save
      flash[:success] = 'Successfully created.'
      redirect_to purchase_orders_path
    else
      render :new
    end
  end
  
  def update
    if @purchase_order.update(purchase_order_params)
      flash[:success] = 'Successfully updated.'
      redirect_to purchase_orders_path
    else
      render :edit
    end
  end
  
  def destroy
    @purchase_order.purchase_order_products.try(:destroy_all)
    @purchase_order.destroy
    respond_with(@purchase_order)
  end
  
  def complete_order
    purchase_order = PurchaseOrder.find_by_id(params[:id])
    order_products = purchase_order.purchase_order_products
    order_products.each do |order_product|
      product             = order_product.product
      product.quantity    = product.quantity + order_product.purchase_quantity
      product.expiry_date = order_product.expiry_date if order_product.expiry_date.present?
      product.save
    end
    purchase_order.is_completed = true
    purchase_order.save
    flash[:success] = 'Order successfully completed'
    redirect_to purchase_orders_path
  end

  def download
    @purchase_order  =  PurchaseOrder.find_by_id(params[:id])
    respond_to do |format|
      format.pdf do
        pdf_name = "#{@purchase_order.name.camelize} | #{Date.today.strftime('%d/%m/%Y')}"
        render pdf: pdf_name,
               disposition: 'attachment',
               layout: 'pdf.html', # use 'pdf.html' for a pdf.html.erb file
               page_offset: 0,
               book: false,
               orientation: 'Landscape',
               # page_width: '2000',
               # dpi: '300',
               default_header: true,
               lowquality: false,
               # save_only:       true,
               margin: {bottom: 10, top: 15},
               header: {
                   html: {
                       template: '/shared/header.pdf.erb', # use :template OR :url
                       layout: 'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 8,
                   margin: {left: 0},
                   line: false
               }, # optionally you can pass plain html already rendered (useful if using pdf_from_string)
               footer: {
                   html: {
                       template: '/shared/footer.pdf.erb', # use :template OR :url
                       layout: 'pdf.html' # optional, use 'pdf_plain.html' for a pdf_plain.html.erb file, defaults to main layout
                   },
                   font_name: 'Times New Roman',
                   font_size: 8,
                   line: true
               }
      end
    end
  end
  
  private
  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end
  
  def purchase_order_params
    params.require(:purchase_order).permit(:name)
  end
end

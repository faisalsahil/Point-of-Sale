class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  before_action :set_product, only: [:new,:edit,:update,:destroy]
   # respond_to :html
  
  def index
    @purchase_orders = PurchaseOrder.all
  end
  
  def show
    @purchase_order
    @purchase_order_products = @purchase_order.purchase_order_products
    respond_to do |format|
      format.html {}
      format.js { render :layout => false }
      format.pdf do
        pdf_name = "#{@purchase_order.id}"
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


  def new
    @purchase_order = PurchaseOrder.new
  end
  
  def edit
  end

  # def add_to_list
  #   @purchase_orders =PurchaseOrder.where(:purchase_orders.id params[:purchase_order] )
  # end

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
    # binding.pry
    @purchase_order.purchase_order_products.try(:destory_all)
    @purchase_order.destroy
    redirect_to purchase_orders_path
  end
  
  def complete_order
    purchase_order = PurchaseOrder.find_by_id(params[:id])
    order_products = purchase_order.purchase_order_products

    order_products.each do |order_product|
      product             = order_product.product
      if product.present?
      product.quantity    = product.quantity + order_product.purchase_quantity
      product.expiry_date = order_product.expiry_date if order_product.expiry_date.present?
      product.save
      else
        product = Product.new
        product.product_name=order_product.name
        product.quantity = order_product.purchase_quantity
        product.expiry_date = order_product.expiry_date
        product.save
      end

    end
     purchase_order.is_completed = true
    if purchase_order.save
      flash[:success] = 'Order successfully completed'
      redirect_to purchase_orders_path
    end
  end


  private
  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end
  def purchase_order_params
    params.require(:purchase_order).permit(
        :id,
        :name,
        purchase_order_products_attributes: [
            :id,
            :current_stock,
            :name,
            :product_id,
            :purchase_quantity,
            :product_id,
            :unit_cost
        ]
    )
  end
  def set_product
    @purchase_order_products=PurchaseOrderProduct.all
  end

  # def purchase_order_params
  #   params.require(:purchase_order).permit(:name)
  # end

  respond_to do |format|
    format.html
  end
end

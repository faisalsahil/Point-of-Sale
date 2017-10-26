class PurchaseOrderProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  protect_from_forgery prepend: true, with: :exception

  before_action :set_purchase_order_product , only: [:show, :edit, :update, :destroy,:update_products]
  before_action :set_product,only: [:new,:edit,:update]

  def new
    @purchase_order = PurchaseOrder.find_by_id(params[:purchase_order_id])
    @purchase_order_product = @purchase_order.purchase_order_products.build
     # binding.pry
    # @purchase_order_product = @purchase_order_product.new

    end

  def create
    @purchase_order = PurchaseOrder.find_by_id(params[:purchase_order_id])
     @purchase_order_product = @purchase_order.purchase_order_products.build(purchase_order_product_params)
    # name = purchase_order_product_params[:name]
    # @product = Product.find_by_product_name(name)
    # @purchase_order_product = @purchase_order.purchase_order_products.build
    # @purchase_order_product = purchase_order_orders_params[:]
    # binding.pry
    if @purchase_order_product.save
      redirect_to purchase_orders_path(@purchase_order)
    else
      puts "sorry there was an error while saving this product"
    end
  end
  def edit
    @purchase_order_product = @purchase_order.purchase_order_products.find_by_id(params[:id])
    # binding.pry
    end

  def update
    binding.pry
    raise params.inspect
    # if @purchase_order_product.update(purchase_order_product_params)
    #   flash[:success] = 'Successfully updated.'
    #   redirect_to purchase_orders_path(@purchase_order)
    # else
    #   render :edit
    # end
    # binding.pry
  end

  def index
   @purchase_order_products = PurchaseOrderProduct.all
   respond_with(@purchase_order_products)
  end

   def show

   end
  def add
    product_ids = params[:product_ids]
    quantities  = params[:quantities]
    quantity = quantities.split(",")
    i=0
    product_ids.split(",").each do |product_id|
 #   while    product_ids !=nil
    products = Product.where(id: product_id)
#   products =Product.find_by_id(params[:product_id])


    @purchase_order = PurchaseOrder.find_by_id(params[:purchase_order_id])
    products.each do |product, index|
#   producs.each_with_index do |product, index|
      purchase_order_product = PurchaseOrderProduct.where("purchase_order_id = ? AND product_id = ?", params[:purchase_order_id], product.id)
      if purchase_order_product.blank?
        @purchase_order_product                   = @purchase_order.purchase_order_products.build
        @purchase_order_product.name              = product.product_name
        @purchase_order_product.product_id        = product.id
        @purchase_order_product.current_stock     = product.try(:quantity)
        @purchase_order_product.purchase_quantity = quantity[i]
        if @purchase_order_product.save
          # redirect_to purchase_item_list_items_path(@purchase_item)
          flash[:success] = 'successfully added to purchase order.'
          end
      else
        @purchase_order_product = @purchase_order.purchase_order_products.find_by_id(purchase_order_product)
        @purchase_order_product.purchase_quantity = @purchase_order_product.purchase_quantity + quantity[i].to_i;
        @purchase_order_product.save
      end
      i = i + 1

    end

    end

    redirect_to purchase_order_path(@purchase_order)
    end

  def update_products
    raise params.inspect
    # binding.pry
  #   ids        = params[:ids]
  #   quantities = params[:quantities]
  #   expiries   = params[:expiries]
  #
  #   purchase_order_products = PurchaseOrderProduct.where(id: ids)
  #   purchase_order_products.each { |o| ids[o.id] = o }
  #
  #   purchase_order_products && purchase_order_products.each_with_index do |order_product, index|
  #     order_product.purchase_quantity = quantities[index]
  #     order_product.expiry_date       = expiries[index]
  #     order_product.save
  #   end
  #   flash[:success] = 'successfully updated purchase order.'
  #   redirect_to purchase_orders_path(@purchase_order)
  end


  def destroy
    @purchase_order.purchase_order_products.find_by_id(params[:id]).delete
    redirect_to purchase_order_path @purchase_order
  end


  private

  def set_purchase_order_product
    @purchase_order_products = PurchaseOrderProduct.all
    @purchase_order = PurchaseOrder.find_by_id(params[:purchase_order_id])
  end

  def purchase_order_product_params
    params.require(:purchase_order_product).permit(
            :purchase_order_id,
            :id,
            :purchase_quantity,
            :product_id,
            :name,
            :expiry_date,
            :current_stock,
            :unit_cost
    )
  end

  def set_product
    @products=Product.all
  end
end

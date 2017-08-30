class PurchaseOrderProductsController < ApplicationController
  
  def add_products
    product_ids = params[:product_ids].split(',')
    quantities  = params[:quantities].split(',')
    
    products        = Product.where(id: product_ids)
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    products && products.each_with_index do |product, index|
      purchase_order_product = PurchaseOrderProduct.where("purchase_order_id = ? AND product_id = ?", params[:purchase_order_id], product.id)
      if purchase_order_product.blank?
        @purchase_order_product                   = @purchase_order.purchase_order_products.build
        @purchase_order_product.name              = product.try(:name)
        @purchase_order_product.product_id        = product.id
        @purchase_order_product.current_stock     = product.try(:quantity)
        @purchase_order_product.purchase_quantity = quantities[index]
        @purchase_order_product.save
      end
    end
    # redirect_to purchase_item_list_items_path(@purchase_item)
    flash[:success] = 'successfully added to purchase order.'
    redirect_to reminders_path
  end
  
  def update_products
    ids        = params[:ids].split(',')
    quantities = params[:quantities].split(',')
    expiries   = params[:expiries].split(',')
    
    purchase_order_products = PurchaseOrderProduct.where(id: ids)
    purchase_order_products.each { |o| ids[o.id] = o }
    
    purchase_order_products && purchase_order_products.each_with_index do |order_product, index|
      order_product.purchase_quantity = quantities[index]
      order_product.expiry_date       = expiries[index]
      order_product.save
    end
    flash[:success] = 'successfully updated purchase order.'
    redirect_to purchase_order_path(purchase_order_products.first.purchase_order_id)
  end
  
  def remove_order_product
    @order_product    = PurchaseOrderProduct.find_by_id(params[:id])
    purchase_order_id = @order_product.purchase_order_id
    @order_product.destroy if @order_product.present?
    redirect_to purchase_order_path(purchase_order_id)
  end
end

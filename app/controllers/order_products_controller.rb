class OrderProductsController < ApplicationController
  
  # def create_order_product
  #   @order = Order.find(params[:order_id])
  #   @product = Product.find_by_id(params[:product_id])
  #   @order_product = OrderProduct.where('product_id = ? AND order_id = ?', params[:product_id], @order.id).first
  #   if @order_product.blank?
  #     @order_product = OrderProduct.new(product_id: params[:product_id], order_id: @order.id, quantity: 1)
  #     # order_product.unit_cost = line_item.item.price
  #     @order_product.save
  #     # remove_item_from_stock(params[:item_id], 1)
  #     # update_line_item_totals(line_item)
  #   else
  #     @order_product.quantity += 1
  #     @order_product.save
  #     # remove_item_from_stock(params[:item_id], 1)
  #     # update_line_item_totals(existing_line_item)
  #   end
  #
  #   # update_totals
  #
  #   respond_to do |format|
  #     format.html { render layout: false }
  #   end
  # end
  #
  # def update_quantity
  #   puts "==="*90
  #   puts params.inspect
  #   return render json: true
  # end
  
  def destroy
    order_product = OrderProduct.find_by_id(params[:id])
    order_id = order_product.order_id
    order_product.destroy
    redirect_to order_path order_id
  end
end
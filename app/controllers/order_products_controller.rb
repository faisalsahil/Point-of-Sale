class OrderProductsController < ApplicationController
  load_and_authorize_resource
   def destroy
     order_product = OrderProduct.find_by_id(params[:id])
     order_id = order_product.order_id
     order_product.destroy
     redirect_to edit_order_path(order_id)
   end
end
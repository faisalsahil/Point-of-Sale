class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products = Product.all.count
    @orders = Order.where("DATE(created_at) = ?",Date.today).count
    @total_sale_today = OrderProduct.where("DATE(created_at) = ?",Date.today).sum("quantity * unit_cost" )
  end
end

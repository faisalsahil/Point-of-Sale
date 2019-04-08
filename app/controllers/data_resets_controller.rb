class DataResetsController < ApplicationController

  def new
  end

  def create
    d = params[:to_date].to_date
    orders = Order.where('created_at <= ?', d)
    orders&.each do |order|
      order.order_products.destroy_all
      order.destroy
    end

    redirect_to root_url
  end
end

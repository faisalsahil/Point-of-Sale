class DataResetsController < ApplicationController

  def new
  end

  def create

    d      = params[:to_date].to_date
    orders = Order.where('extract(year from created_at) = ? AND  extract(month from created_at) <= ? AND extract(day from created_at) <= ?', d.year, d.month, d.day)
    
    orders&.each do |order|
      order.order_products.destroy_all
      order.destroy
    end

    redirect_to root_url
  end
end

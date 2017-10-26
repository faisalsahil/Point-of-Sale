class RemindersController < ApplicationController
  
  def index
    if params[:keyword].blank?
      @products = Product.where("quantity = ? OR Date(expiry_date) <= ? OR expiry_date IS ?", 0, Date.today + 1.month, nil)
    else
      @products = Product.where("lower(product_name) like ?", "%#{params[:keyword]}%".downcase)
    end
    @products = @products.paginate(:page => params[:page], :per_page => 5)
    # @products = @products.sort_by!{ |m| m.product_name.downcase }
    @purchase_orders = PurchaseOrder.where(is_completed: 0)
  end
  
  def edit
    @item = Item.find_by_id(params[:id])  
  end
  
  def update
    @item = Item.find(params[:id])
    prev_stock = @item.quantity
    @item.update_attributes(params[:item])
    @item.quantity += prev_stock
    @item.save
    redirect_to reminders_path
  end
end

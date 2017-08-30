require 'test_helper'

class PurchaseOrderProductsControllerTest < ActionController::TestCase
  setup do
    @purchase_order_product = purchase_order_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_order_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_order_product" do
    assert_difference('PurchaseOrderProduct.count') do
      post :create, purchase_order_product: { current_stock: @purchase_order_product.current_stock, purchase_order_id: @purchase_order_product.purchase_order_id, purchase_quantity: @purchase_order_product.purchase_quantity }
    end

    assert_redirected_to purchase_order_product_path(assigns(:purchase_order_product))
  end

  test "should show purchase_order_product" do
    get :show, id: @purchase_order_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_order_product
    assert_response :success
  end

  test "should update purchase_order_product" do
    patch :update, id: @purchase_order_product, purchase_order_product: { current_stock: @purchase_order_product.current_stock, purchase_order_id: @purchase_order_product.purchase_order_id, purchase_quantity: @purchase_order_product.purchase_quantity }
    assert_redirected_to purchase_order_product_path(assigns(:purchase_order_product))
  end

  test "should destroy purchase_order_product" do
    assert_difference('PurchaseOrderProduct.count', -1) do
      delete :destroy, id: @purchase_order_product
    end

    assert_redirected_to purchase_order_products_path
  end
end

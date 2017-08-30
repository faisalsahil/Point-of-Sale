require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get purchase_order" do
    get :purchase_order
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { avg_purchase_price: @product.avg_purchase_price, is_purchase_margin: @product.is_purchase_margin, is_sale_discount: @product.is_sale_discount, product_brand_id: @product.product_brand_id, product_category_id: @product.product_category_id, product_company_id: @product.product_company_id, product_description: @product.product_description, product_image: @product.product_image, product_name: @product.product_name, product_nature_id: @product.product_nature_id, product_type_id: @product.product_type_id, product_unit_id: @product.product_unit_id, purchase_margin: @product.purchase_margin, sale_discount_flat: @product.sale_discount_flat, sale_discount_percent: @product.sale_discount_percent, sale_price: @product.sale_price }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { avg_purchase_price: @product.avg_purchase_price, is_purchase_margin: @product.is_purchase_margin, is_sale_discount: @product.is_sale_discount, product_brand_id: @product.product_brand_id, product_category_id: @product.product_category_id, product_company_id: @product.product_company_id, product_description: @product.product_description, product_image: @product.product_image, product_name: @product.product_name, product_nature_id: @product.product_nature_id, product_type_id: @product.product_type_id, product_unit_id: @product.product_unit_id, purchase_margin: @product.purchase_margin, sale_discount_flat: @product.sale_discount_flat, sale_discount_percent: @product.sale_discount_percent, sale_price: @product.sale_price }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end

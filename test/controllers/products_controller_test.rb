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

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { bar_code: @product.bar_code, category_id: @product.category_id, code: @product.code, comments: @product.comments, max_stick: @product.max_stick, min_stock: @product.min_stock, name: @product.name, price: @product.price, short_name: @product.short_name, unit_id: @product.unit_id }
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
    patch :update, id: @product, product: { bar_code: @product.bar_code, category_id: @product.category_id, code: @product.code, comments: @product.comments, max_stick: @product.max_stick, min_stock: @product.min_stock, name: @product.name, price: @product.price, short_name: @product.short_name, unit_id: @product.unit_id }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end

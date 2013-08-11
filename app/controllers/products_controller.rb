class ProductsController < ApplicationController

  def index
    @search = params[:search] || {}
    @products = Product.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(permitted_params)
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  def search_code
    render json: Product.terms_code_for(params[:term])
  end

  def search_name
    render json: Product.terms_name_for(params[:term])
  end

  private

  def permitted_params
    params[:product].permit(
      :id,
      :name,
      :short_name,
      :price,
      :unit_id,
      :code,
      :category_id,
      :comments,
      :min_stock,
      :max_stock,
      :existence,
      :bar_code,
      :quantity_package,
      :purchase_price,
      :category_ids => [],
      :supplier_ids => [])
  end
end

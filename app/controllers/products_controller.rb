class ProductsController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @products = Product.by_account(current_user)
                       .search(params[:search])
                       .paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.csv do
        @products = Product.by_account(current_user).search(params[:search])
        headers['Content-Disposition'] = "attachment; filename=\"productos.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params)
    @product.account = current_user.account if current_user.account

    if @product.save
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def edit
    @product = find_record
  end

  def update
    @product = find_record

    if @product.update(permitted_params)
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def show
    @product = find_record
  end

  def destroy
    @product = find_record
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

  def find_record
    Product.find_record(params[:id], current_user.account)
  end
end

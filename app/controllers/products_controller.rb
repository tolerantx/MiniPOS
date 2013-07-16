class ProductsController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @products = Product.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:product => [ :id, :name, :short_name, :price, :unit_id, :code, :category_id,
      :comments, :min_stock, :max_stock, :existence, :bar_code ])
  end
end

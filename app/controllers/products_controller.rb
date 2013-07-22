class ProductsController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @products = Product.search(params[:search]).paginate(:page => params[:page])
  end

  def search_code
    render json: Product.terms_code_for(params[:term])
  end

  def search_name
    render json: Product.terms_name_for(params[:term])
  end

  private

  def permitted_params
    params.permit(:product => [ :id, :name, :short_name, :price, :unit_id, :code, :category_id,
      :comments, :min_stock, :max_stock, :existence, :bar_code, :category_ids => [] ])
  end
end

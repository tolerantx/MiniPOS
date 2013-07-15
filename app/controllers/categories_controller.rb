class CategoriesController < InheritedResources::Base

  def index
    @search = params[:search] || {}
    @categories = Category.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:category => [ :id, :name ])
  end
end

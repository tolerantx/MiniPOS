class UnitsController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @units = Unit.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:unit => [ :id, :name ])
  end

end

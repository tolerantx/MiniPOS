class UnitsController < ApplicationController
  load_and_authorize_resource

  def index
    @search = params[:search] || {}
    @units = Unit.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(permitted_params)

    if @unit.save
      redirect_to unit_path(@unit)
    else
      render 'new'
    end
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update(permitted_params)
      redirect_to unit_path(@unit)
    else
      render 'edit'
    end
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    redirect_to units_path
  end

  private

  def permitted_params
    params[:unit].permit(:id, :name)
  end

end

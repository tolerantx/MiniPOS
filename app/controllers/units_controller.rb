class UnitsController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @units = Unit.by_account(current_user)
                 .search(params[:search])
                 .paginate(:page => params[:page])
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(permitted_params)
    @unit.account = current_user.account if current_user.account

    if @unit.save
      redirect_to unit_path(@unit)
    else
      render 'new'
    end
  end

  def edit
    @unit = find_record
  end

  def update
    @unit = find_record
    if @unit.update(permitted_params)
      redirect_to unit_path(@unit)
    else
      render 'edit'
    end
  end

  def show
    @unit = find_record
  end

  def destroy
    @unit = find_record
    @unit.destroy

    redirect_to units_path
  end

  private

  def permitted_params
    params[:unit].permit(:id, :name)
  end

  def find_record
    Unit.find_record(params[:id], current_user.account)
  end
end

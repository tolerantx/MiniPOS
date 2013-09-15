class SuppliersController < ApplicationController

  def index
    @search = params[:search] || {}
    @suppliers = Supplier.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @supplier = Supplier.new(:address => Address.new)
  end

  def create
    @supplier = Supplier.new(permitted_params)

    if @supplier.save
      redirect_to supplier_path(@supplier)
    else
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])

    if @supplier.update(permitted_params)
      redirect_to supplier_path(@supplier)
    else
      render 'edit'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    redirect_to suppliers_path
  end

  private

    def permitted_params
      params[:supplier].permit(
        :id,
        :name,
        :product_ids => [],
        address_attributes: [:address1, :address2, :state, :city, :town, :location, :zip_code, :comments],
        phones_attributes: [:number, :phone_type, :_destroy, :id],
        emails_attributes: [:email, :email_type, :_destroy, :id]
      )
    end
end

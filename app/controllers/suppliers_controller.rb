class SuppliersController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @suppliers = Supplier.by_account(current_user)
                         .search(params[:search])
                         .paginate(:page => params[:page])
  end

  def new
    @supplier = Supplier.new(:address => Address.new)
  end

  def create
    @supplier = Supplier.new(permitted_params)
    @supplier.account = current_user.account if current_user.account

    if @supplier.save
      redirect_to supplier_path(@supplier)
    else
      render 'new'
    end
  end

  def edit
    @supplier = find_record
  end

  def update
    @supplier = find_record

    if @supplier.update(permitted_params)
      redirect_to supplier_path(@supplier)
    else
      render 'edit'
    end
  end

  def show
    @supplier = find_record
  end

  def destroy
    @supplier = find_record
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

  def find_record
    Supplier.find_record(params[:id], current_user.account)
  end
end

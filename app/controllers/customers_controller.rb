class CustomersController < ApplicationController
  load_and_authorize_resource except: [:create]


  def index
    @search = params[:search] || {}
    @customers = Customer.by_account(current_user)
                         .search(params[:search])
                         .paginate(:page => params[:page])
  end

  def new
    @customer = Customer.new(:address => Address.new)
  end

  def create
    @customer = Customer.new(permitted_params)
    @customer.account = current_user.account if current_user.account

    if @customer.save
      redirect_to customer_path(@customer)
    else
      render 'new'
    end
  end

  def edit
    @customer = find_record
  end

  def update
    @customer = find_record

    if @customer.update(permitted_params)
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

  def show
    @customer = find_record
  end

  def destroy
    @customer = find_record
    @customer.destroy

    redirect_to customers_path
  end

  def search_name
    render json: Customer.terms_name_for(params[:term])
  end

  private

  def permitted_params
    params[:customer].permit(
      :id,
      :first_name,
      :last_name,
      address_attributes: [:address1, :address2, :state, :city, :town, :location, :zip_code, :comments],
      phones_attributes: [:number, :phone_type, :_destroy, :id],
      emails_attributes: [:email, :email_type, :_destroy, :id]
    )
  end

  def find_record
    Customer.find_record(params[:id], current_user.account)
  end
end

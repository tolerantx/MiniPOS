class CustomersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = params[:search] || {}
    @customers = Customer.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @customer = Customer.new(:address => Address.new)
  end

  def create
    @customer = Customer.new(permitted_params)

    if @customer.save
      redirect_to customer_path(@customer)
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(permitted_params)
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
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
end

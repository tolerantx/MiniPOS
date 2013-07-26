class SuppliersController < InheritedResources::Base

  def index
    @search = params[:search] || {}
    @suppliers = Supplier.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @supplier = Supplier.new(:address => Address.new)
  end

  private

    def permitted_params
      params.permit(:supplier => [
        :id,
        :name,
        :product_ids => [],
        address_attributes: [:address1, :address2, :state, :city, :town, :location, :zip_code, :comments],
        phones_attributes: [:number, :phone_type, :_destroy, :id],
        emails_attributes: [:email, :email_type, :_destroy, :id]
      ])
    end
end

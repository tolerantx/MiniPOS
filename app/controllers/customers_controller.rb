class CustomersController < InheritedResources::Base

  private

    def permitted_params
      params.permit(:customer => [:first_name, :last_name])
    end
end

class TicketsController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @tickets = Ticket.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:ticket => [
      :customer_id,
      :total,
      :status,
      items_attributes: [:quantity, :unit, :code, :description, :unit_value, :amount]
    ])
  end

end

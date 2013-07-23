class TicketsController < InheritedResources::Base
  actions :all, :except => [ :edit, :update, :destroy ]

  def index
    @search = params[:search] || {}
    @tickets = Ticket.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:ticket => [
      :id,
      :customer_id,
      :total,
      :status,
      items_attributes: [:quantity, :unit, :code, :description, :unit_value, :amount, :_destroy, :id]
    ])
  end

end

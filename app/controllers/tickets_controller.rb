class TicketsController < InheritedResources::Base
  actions :all, :except => [ :edit, :update, :destroy ]

  def index
    @search = params[:search] || {}
    @tickets = Ticket.search(params[:search]).paginate(:page => params[:page])
  end

  def deliver
    @ticket = Ticket.find(params[:id])
    @ticket.deliver
    redirect_to :action => 'index'
  end

  def cancel
    @ticket = Ticket.find(params[:id])
    @ticket.cancel
    redirect_to :action => 'index'
  end

  private

  def permitted_params
    params.permit(:ticket => [
      :id,
      :customer_id,
      :total,
      :status,
      items_attributes: [:quantity, :unit, :code, :description, :unit_value, :amount, :_destroy, :id, :product_id]
    ])
  end

end

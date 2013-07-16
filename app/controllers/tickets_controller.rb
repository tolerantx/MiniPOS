class TicketsController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @tickets = Ticket.search(params[:search]).paginate(:page => params[:page])
  end

  private

  def permitted_params
    params.permit(:ticket => [:customer_id, :total, :status])
  end

end

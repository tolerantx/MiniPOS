class TicketsController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @tickets = Ticket.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(permitted_params)

    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      render 'new'
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
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
    params[:ticket].permit(
      :id,
      :customer_id,
      :total,
      :status,
      items_attributes: [:quantity, :unit, :code, :description, :unit_value, :amount, :_destroy, :id, :product_id]
    )
  end

end

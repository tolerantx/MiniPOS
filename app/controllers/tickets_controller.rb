class TicketsController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @tickets = Ticket.by_account(current_user)
                     .search(params[:search])
                     .paginate(:page => params[:page])
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(permitted_params)
    @ticket.account = current_user.account if current_user.account

    if @ticket.save
      redirect_to ticket_path(@ticket)
    else
      render 'new'
    end
  end

  def show
    @ticket = find_record
  end

  def deliver
    @ticket = find_record
    @ticket.deliver
    redirect_to :action => 'index'
  end

  def cancel
    @ticket = find_record
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

  def find_record
    Ticket.find_record(params[:id], current_user.account)
  end
end

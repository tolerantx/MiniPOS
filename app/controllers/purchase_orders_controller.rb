class PurchaseOrdersController < ApplicationController
  load_and_authorize_resource except: [:create]

  def index
    @search = params[:search] || {}
    @purchase_orders = PurchaseOrder.by_account(current_user)
                                    .search(params[:search])
                                    .paginate(:page => params[:page])
  end

  def new
    @purchase_order = PurchaseOrder.new
  end

  def create
    @purchase_order = PurchaseOrder.new(permitted_params)
    @purchase_order.account = current_user.account if current_user.account

    if @purchase_order.save
      redirect_to purchase_order_path(@purchase_order)
    else
      render 'new'
    end
  end

  def edit
    @purchase_order = find_record
  end

  def update
    @purchase_order = find_record

    if @purchase_order.update(permitted_params)
      @purchase_order.receive
      @purchase_order.update_attribute :received_at, Time.now

      redirect_to purchase_order_path(@purchase_order)
    else
      render 'edit'
    end
  end

  def show
    @purchase_order = find_record
  end

  def receive
    @purchase_order = find_record
    @purchase_order.receive
    @purchase_order.update_attribute :received_at, Time.now
    redirect_to :action => 'index'
  end

  def cancel
    @purchase_order = find_record
    @purchase_order.cancel
    redirect_to :action => 'index'
  end

  private

  def permitted_params
    params[:purchase_order].permit(
      :id,
      :supplier_id,
      :received_at,
      :status,
      :total,
      items_attributes: [
        :quantity,
        :unit,
        :code,
        :description,
        :unit_value,
        :amount,
        :quantity_required,
        :product_id,
        :_destroy,
        :id
      ]
    )
  end

  def find_record
    PurchaseOrder.find_record(params[:id], current_user.account)
  end
end

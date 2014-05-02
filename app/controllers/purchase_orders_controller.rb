class PurchaseOrdersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = params[:search] || {}
    @purchase_orders = PurchaseOrder.search(params[:search]).paginate(:page => params[:page])
  end

  def new
    @purchase_order = PurchaseOrder.new
  end

  def create
    @purchase_order = PurchaseOrder.new(permitted_params)

    if @purchase_order.save
      redirect_to purchase_order_path(@purchase_order)
    else
      render 'new'
    end
  end

  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def update
    @purchase_order = PurchaseOrder.find(params[:id])

    if @purchase_order.update(permitted_params)
      @purchase_order.receive
      @purchase_order.update_attribute :received_at, Time.now

      redirect_to purchase_order_path(@purchase_order)
    else
      render 'edit'
    end
  end

  def show
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def receive
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.receive
    @purchase_order.update_attribute :received_at, Time.now
    redirect_to :action => 'index'
  end

  def cancel
    @purchase_order = PurchaseOrder.find(params[:id])
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
end

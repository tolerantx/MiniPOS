class PurchaseOrdersController < InheritedResources::Base
  def index
    @search = params[:search] || {}
    @purchase_orders = PurchaseOrder.search(params[:search]).paginate(:page => params[:page])
  end

  def update
    @purchase_order = PurchaseOrder.find(params[:id])
    @purchase_order.receive
    @purchase_order.update_attribute :received_at, Time.now

    # if @purchase_order.update_attributes(permitted_params_update)

    #   redirect_to purchase_order_path(@purchase_order)
    # else
    #   render :action => 'edit'
    # end
    update! { purchase_order_path(resource) }
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
    params.permit(:purchase_order => [
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
    ])
  end
end

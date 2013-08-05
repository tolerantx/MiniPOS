class PurchaseOrderDetail < ActiveRecord::Base
  belongs_to :purchase_order
  belongs_to :product

  after_update :update_stock

  def increment_stock
    product.increment!(:existence, quantity) if product
  end

  private

  def update_stock
    increment_stock if self.purchase_order.received? && (quantity != quantity_was)
  end
end

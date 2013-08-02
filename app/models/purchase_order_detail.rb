class PurchaseOrderDetail < ActiveRecord::Base
  belongs_to :purchase_order
  after_update :update_stock

  def increment_stock
    product = Product.find self.product_id
    product.increment!(:existence, quantity) if product
  end

  def update_stock
    increment_stock if self.purchase_order.received? && (quantity != quantity_was)
  end
end

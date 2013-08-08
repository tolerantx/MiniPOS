class Item < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :product

  def decrement_stock
    product.decrement!(:existence, quantity) if product_id
  end

end

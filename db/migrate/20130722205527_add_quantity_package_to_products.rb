class AddQuantityPackageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :quantity_package, :decimal, :precision => 10, :scale => 2
    add_column :products, :purchase_price, :decimal, :precision => 10, :scale => 2
  end
end

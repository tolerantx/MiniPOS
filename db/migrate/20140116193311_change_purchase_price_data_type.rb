class ChangePurchasePriceDataType < ActiveRecord::Migration
  def change
    change_column :products, :quantity_package, :integer
  end
end

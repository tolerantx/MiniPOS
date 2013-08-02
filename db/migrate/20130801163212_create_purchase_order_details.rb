class CreatePurchaseOrderDetails < ActiveRecord::Migration
  def change
    create_table :purchase_order_details do |t|
      t.integer :purchase_order_id
      t.integer :product_id
      t.decimal :quantity, :precision => 10, :scale => 2
      t.string :unit
      t.string :code
      t.string :description
      t.decimal :unit_value, :precision => 10, :scale => 2
      t.decimal :amount, :precision => 10, :scale => 2
      t.decimal :quantity_required, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end

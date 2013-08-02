class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer :supplier_id
      t.decimal :total, :precision => 10, :scale => 2
      t.datetime :received_at
      t.string :state
      t.string :invoice_number

      t.timestamps
    end
  end
end

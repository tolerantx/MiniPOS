class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :customer_id
      t.decimal :total, :precision => 10, :scale => 2
      t.string :status

      t.timestamps
    end
  end
end

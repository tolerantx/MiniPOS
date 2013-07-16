class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :customer_id
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end

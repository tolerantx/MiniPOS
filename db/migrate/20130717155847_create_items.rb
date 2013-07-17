class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :ticket_id
      t.decimal :quantity, :precision => 10, :scale => 2
      t.string :unit
      t.string :code
      t.string :description
      t.decimal :unit_value, :precision => 10, :scale => 2
      t.decimal :amount, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end

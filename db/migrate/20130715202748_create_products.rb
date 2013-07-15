class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :short_name
      t.decimal :price
      t.integer :unit_id
      t.string :code
      t.integer :category_id
      t.text :comments
      t.integer :min_stock
      t.integer :max_stick
      t.string :bar_code

      t.timestamps
    end
  end
end

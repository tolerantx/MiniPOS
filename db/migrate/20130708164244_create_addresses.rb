class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :town
      t.string :location
      t.text :comments
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end

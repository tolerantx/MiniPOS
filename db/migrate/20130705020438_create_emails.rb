class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.string :address_type
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end

class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.string :email_type
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end
end

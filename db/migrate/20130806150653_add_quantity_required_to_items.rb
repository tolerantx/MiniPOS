class AddQuantityRequiredToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity_required, :decimal, :precision => 10, :scale => 2
    add_column :items, :owner_id, :integer
    add_column :items, :owner_type, :string
  end
end

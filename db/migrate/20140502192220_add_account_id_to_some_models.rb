class AddAccountIdToSomeModels < ActiveRecord::Migration
  def change
    add_column :categories, :account_id, :integer
    add_column :customers, :account_id, :integer
    add_column :purchase_orders, :account_id, :integer
    add_column :products, :account_id, :integer
    add_column :recipients, :account_id, :integer
    add_column :suppliers, :account_id, :integer
    add_column :tickets, :account_id, :integer
    add_column :units, :account_id, :integer
  end
end

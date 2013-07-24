class RemoveCustomerIdTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :customer_id
  end
end

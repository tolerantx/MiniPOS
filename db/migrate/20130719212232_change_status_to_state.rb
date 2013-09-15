class ChangeStatusToState < ActiveRecord::Migration
  def self.up
    rename_column :tickets, :status, :state
  end

  def self.down
    rename_column :tickets, :state, :status
  end
end

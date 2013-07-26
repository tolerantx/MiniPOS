class ProductsSuppliersTable < ActiveRecord::Migration
    def self.up
    create_table :products_suppliers, :id => false do |t|
        t.references :product
        t.references :supplier
    end

    add_index :products_suppliers, [:product_id, :supplier_id], :name => 'index_product_id_supplier_id'
    add_index :products_suppliers, [:supplier_id, :product_id], :name => 'index_supplier_id_product_id'
  end

  def self.down
    drop_table :products_suppliers
  end
end

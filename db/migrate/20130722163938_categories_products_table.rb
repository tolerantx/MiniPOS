class CategoriesProductsTable < ActiveRecord::Migration
  def self.up
    create_table :categories_products, :id => false do |t|
        t.references :category
        t.references :product
    end

    add_index :categories_products, [:category_id, :product_id], :name => 'index_category_id_product_id'
    add_index :categories_products, [:product_id, :category_id], :name => 'index_product_id_category_id'
  end

  def self.down
    drop_table :categories_products
  end
end

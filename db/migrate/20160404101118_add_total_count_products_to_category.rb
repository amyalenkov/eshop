class AddTotalCountProductsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :total_count_products, :integer
  end
end

class AddParentIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :parent_id, :integer
    add_column :categories, :path, :ltree

    add_index :categories, :parent_id
  end
end

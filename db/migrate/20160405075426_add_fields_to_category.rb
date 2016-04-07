class AddFieldsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_leaf, :boolean
    add_column :categories, :level, :integer
  end
end

class AddSidToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sid, :integer
  end
end

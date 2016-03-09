class AddMinCountForRow < ActiveRecord::Migration
  def change
    add_column :rows, :min_count, :integer
  end
end

class RemoveMinCountFromRows < ActiveRecord::Migration
  def change
    remove_column :rows, :min_count
  end
end

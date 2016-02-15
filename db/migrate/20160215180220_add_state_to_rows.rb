class AddStateToRows < ActiveRecord::Migration
  def change
    add_column :rows, :state, :integer, default: 0
  end
end

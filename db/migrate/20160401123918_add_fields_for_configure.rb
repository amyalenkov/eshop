class AddFieldsForConfigure < ActiveRecord::Migration
  def change
    add_column :configures, :day_of_week, :integer, default: 0
    add_column :configures, :time, :time
  end
end

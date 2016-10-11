class AddFieldForUser < ActiveRecord::Migration
  def change
    add_column :users, :sort_by, :text
  end
end

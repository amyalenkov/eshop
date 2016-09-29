class AddMarkUpForcategories < ActiveRecord::Migration
  def change
    add_column :categories, :mark_up, :text
  end
end

class AddColumImageForCategories < ActiveRecord::Migration
  def change
    add_column :categories, :logo_image, :text
  end
end

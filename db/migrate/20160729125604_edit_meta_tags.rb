class EditMetaTags < ActiveRecord::Migration
  def change
    remove_column :meta_tags, :name
    add_column :meta_tags, :name, :string
    remove_column :meta_tags, :title
    add_column :meta_tags, :title, :string
    remove_column :meta_tags, :description
    add_column :meta_tags, :description, :string
  end
end

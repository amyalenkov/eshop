class DeleteTitleFromComment < ActiveRecord::Migration
  def change
    remove_column :comments, :title, :text
  end
end

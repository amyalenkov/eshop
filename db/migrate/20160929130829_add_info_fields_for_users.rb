class AddInfoFieldsForUsers < ActiveRecord::Migration
  def change
    add_column :users, :choice_delivery, :text
    add_column :users, :after_stop, :text
    add_column :users, :info_stop, :text
    add_column :users, :info_delivery, :text
  end
end

class ChangeDefaultValueForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :choice_delivery, :text
    remove_column :users, :after_stop, :text
    remove_column :users, :info_stop, :text
    remove_column :users, :info_delivery, :text

    add_column :users, :choice_delivery, :boolean, :default => false
    add_column :users, :after_stop, :boolean, :default => false
    add_column :users, :info_stop, :boolean, :default => false
    add_column :users, :info_delivery, :boolean, :default => false
  end
end

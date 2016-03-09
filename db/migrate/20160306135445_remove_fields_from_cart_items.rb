class RemoveFieldsFromCartItems < ActiveRecord::Migration
  def change
    remove_belongs_to :cart_items, :row
    remove_belongs_to :cart_items, :order
    remove_column :cart_items, :state
  end
end

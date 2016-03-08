class AddOrderToRowItems < ActiveRecord::Migration
  def change
    add_reference :row_items, :order_item
  end
end

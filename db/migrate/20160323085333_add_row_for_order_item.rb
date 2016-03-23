class AddRowForOrderItem < ActiveRecord::Migration
  def change
    add_reference :order_items, :row
  end
end

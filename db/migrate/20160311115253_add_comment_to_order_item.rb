class AddCommentToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :comment, :text
  end
end

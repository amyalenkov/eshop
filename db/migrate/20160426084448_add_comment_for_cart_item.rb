class AddCommentForCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :comment, :text
  end
end

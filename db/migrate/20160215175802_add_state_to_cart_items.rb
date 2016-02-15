class AddStateToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :state, :integer, default: 0
  end
end

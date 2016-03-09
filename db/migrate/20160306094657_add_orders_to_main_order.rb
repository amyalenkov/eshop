class AddOrdersToMainOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :main_order
  end
end

class CreateMainOrders < ActiveRecord::Migration
  def change
    create_table :main_orders do |t|
      t.integer :state, default: 0
      t.timestamps
    end
  end
end

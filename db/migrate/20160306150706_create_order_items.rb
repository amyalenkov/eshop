class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :price
      t.integer :count
      t.integer :state, default: 0
      t.references :product, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end

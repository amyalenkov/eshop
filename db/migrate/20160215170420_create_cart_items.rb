class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :count
      t.decimal :total_price
      t.references :user, index: true
      t.references :product, index: true
      t.references :row, index: true
      t.references :order, index: true

      t.timestamps
    end
  end
end

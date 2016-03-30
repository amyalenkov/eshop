class CreateDeliveryPosts < ActiveRecord::Migration
  def change
    create_table :delivery_posts do |t|
      t.references :order, index: true
      t.text :address
      t.timestamps
    end
  end
end

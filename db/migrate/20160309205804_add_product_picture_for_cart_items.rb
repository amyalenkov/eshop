class AddProductPictureForCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :product_picture, :string
  end
end

class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.string :url
      t.references :product, index: true

      t.timestamps
    end
  end
end

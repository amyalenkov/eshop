class CreateProductParams < ActiveRecord::Migration
  def change
    create_table :product_params do |t|
      t.string :name
      t.string :value
      t.references :product, index: true

      t.timestamps
    end
  end
end

class RemakeProductsFields < ActiveRecord::Migration
  def change
    add_column :products, :tm, :string
    add_column :products, :articul, :string
    add_column :products, :packaging_type, :string
    add_column :products, :composition, :string
    add_column :products, :note, :string
    add_column :products, :depth, :string
    add_column :products, :width, :string
    add_column :products, :height, :string
    add_column :products, :packing_length, :string
    add_column :products, :packing_width, :string
    add_column :products, :packing_height, :string
    add_column :products, :min, :string
    add_column :products, :multiplicity, :string
    add_column :products, :packing, :string



    remove_column :products, :sales_notes
    remove_column :products, :local_delivery_cost
    remove_column :products, :delivery
    remove_column :products, :vendor
    remove_column :products, :articul


  end
end

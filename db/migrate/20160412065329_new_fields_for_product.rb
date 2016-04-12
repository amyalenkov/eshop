class NewFieldsForProduct < ActiveRecord::Migration
  def change
    add_column :products, :country_id, :integer
    add_column :products, :color_id, :integer
    add_column :products, :trademark_id, :integer
    add_column :products, :k_min, :boolean
    add_column :products, :is_hit, :boolean
    add_column :products, :min_qty, :integer
    add_column :products, :photo_count, :integer
    add_column :products, :balance_text, :string
    add_column :products, :box_size_text, :string
    add_column :products, :materials_text, :string
    add_column :products, :size_text, :string
    add_column :products, :unit, :string
    add_column :products, :image, :string

    remove_column :products, :available
    remove_column :products, :currency
    remove_column :products, :bid
    remove_column :products, :tm
    remove_column :products, :packaging_type
    remove_column :products, :packing
    remove_column :products, :packing_height
    remove_column :products, :packing_length
    remove_column :products, :packing_width
    remove_column :products, :composition
    remove_column :products, :note
    remove_column :products, :min
    remove_column :products, :multiplicity
    remove_column :products, :price
    add_column :products, :price, :float
  end
end

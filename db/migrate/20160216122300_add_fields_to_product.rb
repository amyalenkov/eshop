class AddFieldsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :available, :boolean
    add_column :products, :currency, :string
    add_column :products, :price, :decimal
    add_column :products, :delivery, :boolean
    add_column :products, :local_delivery_cost, :integer
    add_column :products, :description, :text
    add_column :products, :sales_notes, :string
    add_column :products, :bid, :integer
    add_reference :products, :subcategory
  end
end

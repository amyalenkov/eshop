class AddNewTypeForProducts < ActiveRecord::Migration
  def change
    add_column :products, :new_type_id, :integer
  end
end

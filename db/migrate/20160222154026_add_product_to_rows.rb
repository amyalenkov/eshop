class AddProductToRows < ActiveRecord::Migration
  def change
    add_reference :rows, :product
  end
end

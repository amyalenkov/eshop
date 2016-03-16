class AddRowsToMainOrder < ActiveRecord::Migration
  def change
    add_reference :rows, :main_order
  end
end

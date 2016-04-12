class AddArticulToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sid, :integer
  end
end

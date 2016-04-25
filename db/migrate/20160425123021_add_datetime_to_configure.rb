class AddDatetimeToConfigure < ActiveRecord::Migration
  def change
    add_column :countries, :date, :date
  end
end

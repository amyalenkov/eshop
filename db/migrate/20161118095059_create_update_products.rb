class CreateUpdateProducts < ActiveRecord::Migration
  def change
    create_table :update_products do |t|
      t.references :category, index: true
      t.datetime :last_update_start
      t.datetime :last_update_finish
      t.timestamps
    end
  end
end

class CreateRowItems < ActiveRecord::Migration
  def change
    create_table :row_items do |t|
      t.integer :count
      t.references :row, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

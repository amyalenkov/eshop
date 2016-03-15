class CreateRowComments < ActiveRecord::Migration
  def change
    create_table :row_comments do |t|
      t.references :user, index: true
      t.references :row, index: true
      t.text :comment
      t.timestamps
    end
  end
end

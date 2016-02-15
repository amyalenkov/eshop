class CreateRows < ActiveRecord::Migration
  def change
    create_table :rows do |t|
      t.integer :min_count
      t.integer :current_count

      t.timestamps
    end
  end
end

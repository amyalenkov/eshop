class CreateAdditionals < ActiveRecord::Migration
  def change
    create_table :additionals do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
  end
end

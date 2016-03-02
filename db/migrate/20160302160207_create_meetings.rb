class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :admin_user
      t.text :description

      t.timestamps
    end
  end
end

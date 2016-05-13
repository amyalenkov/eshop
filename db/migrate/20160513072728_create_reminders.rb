class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.string :value
      t.date :start_date
      t.date :stop_date
      t.timestamps
    end
  end
end

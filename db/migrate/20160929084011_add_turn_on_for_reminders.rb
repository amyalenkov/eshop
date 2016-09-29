class AddTurnOnForReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :turn_on, :boolean
  end
end

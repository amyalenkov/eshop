class EditRegisteredTimeAndDateToMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :meeting_date
    add_column :meetings, :meeting_date, :date
    remove_column :meetings, :registered_time
    add_column :meetings, :registered_time, :text
  end
end

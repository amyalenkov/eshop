class EditDateToMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :meeting_date
    add_column :meetings, :meeting_date, :text
  end
end

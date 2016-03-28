class AddDatesForMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_date, :date
    add_column :meetings, :registered_time, :datetime
  end
end

class RemoveStartTimeFromCalendarDates < ActiveRecord::Migration
  def change
    remove_column :calendar_dates, :start_time
  end
end

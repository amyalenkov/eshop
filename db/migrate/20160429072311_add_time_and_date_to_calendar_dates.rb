class AddTimeAndDateToCalendarDates < ActiveRecord::Migration
  def change
    add_column :calendar_dates, :time, :time
    add_column :calendar_dates, :date, :date
  end
end

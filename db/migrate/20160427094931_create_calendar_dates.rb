class CreateCalendarDates < ActiveRecord::Migration
  def change
    create_table :calendar_dates do |t|
      t.string :name
      t.datetime :start_time
      t.timestamps
    end
  end
end

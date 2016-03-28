class CreateMeetingItems < ActiveRecord::Migration
  def change
    create_table :meeting_items do |t|
      t.text :location
      t.time :time
      t.timestamps
    end
  end
end

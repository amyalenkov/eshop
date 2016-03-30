class CreateMeetingDeliveries < ActiveRecord::Migration
  def change
    create_table :meeting_deliveries do |t|
      t.references :order, index: true
      t.timestamps
    end
  end
end

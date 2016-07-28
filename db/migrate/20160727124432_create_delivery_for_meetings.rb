class CreateDeliveryForMeetings < ActiveRecord::Migration
  def change
    create_table :delivery_meetings do |t|
      t.string :order_id
      t.datetime :address
      t.timestamps
    end
  end
end

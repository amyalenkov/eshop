class AddMeetingItemToMeetingDelivery < ActiveRecord::Migration
  def change
    add_reference :meeting_deliveries, :meeting_item, index: true
  end
end

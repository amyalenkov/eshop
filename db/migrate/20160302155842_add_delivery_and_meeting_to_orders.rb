class AddDeliveryAndMeetingToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery, :integer, default: 0
    add_reference :orders, :meeting
  end
end

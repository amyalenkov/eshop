class AddMainOrderToMeetings < ActiveRecord::Migration
  def change
    add_reference :meetings, :main_order, index: true
  end
end

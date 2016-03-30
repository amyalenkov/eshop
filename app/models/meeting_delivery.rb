class MeetingDelivery < ActiveRecord::Base
  has_one :meeting_item
end

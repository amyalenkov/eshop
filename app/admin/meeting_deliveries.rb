ActiveAdmin.register MeetingDelivery do

  menu label: 'Доставка на встречу'

  permit_params :id, :order_id, :meeting_item_id

  config.per_page = 30

  filter :description

end

ActiveAdmin.register MeetingItem do

  menu label: 'Места встреч'

  permit_params :location, :time

  config.per_page = 30

end

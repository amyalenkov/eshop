ActiveAdmin.register MeetingItem do
  permit_params :location, :time

  config.per_page = 30

end

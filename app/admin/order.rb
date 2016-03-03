ActiveAdmin.register Order do

  permit_params :meeting_id

  config.per_page = 30

  filter :total_price

end

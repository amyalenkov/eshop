ActiveAdmin.register OrderItem do

  permit_params :state

  config.per_page = 30

  filter :state

end

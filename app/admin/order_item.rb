ActiveAdmin.register OrderItem do

  menu label: 'Пункты заказа'

  permit_params :state

  config.per_page = 30

  filter :state

end

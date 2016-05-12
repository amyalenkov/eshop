ActiveAdmin.register Product do

  menu label: 'Товары'

  config.per_page = 30

  filter :name

end

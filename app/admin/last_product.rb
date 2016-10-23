ActiveAdmin.register LastProduct do

  menu label: 'Последние продукты'

  config.per_page = 30

  filter :user, label: 'Юзер'

end

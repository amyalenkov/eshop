ActiveAdmin.register CartItem do

  menu label: 'Корзина пользователей'

  config.per_page = 30

  filter :user, label: 'Юзер'

end

ActiveAdmin.register Category, :as => 'All Categories' do

  menu label: 'Категории'

  config.per_page = 30

  filter :name

end

ActiveAdmin.register Additional do

  permit_params :name, :value

  menu label: 'Конфигурация'

  index :title => 'Конфигурация' do
    selectable_column
    column 'Название', :name
    column 'Значение', :value
    actions
  end


  config.per_page = 30

  filter :name, label: 'Название'

end

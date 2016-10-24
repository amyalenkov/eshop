ActiveAdmin.register Configure do

  permit_params :name, :value, :day_of_week, :time

  config.per_page = 30


  menu label: 'Настройка стопа и оплаты'

  index :title => 'Настройка стопа и оплаты' do
    selectable_column
    column 'Название', :name
    column 'День недели', :day_of_week
    column 'Время', :time
    actions
  end

  form do |f|
    f.inputs 'Редактирование' do
      # f.input :name
      f.input :day_of_week, as: :select, collection: Configure.day_of_weeks.keys.to_a
      f.input :time
      # f.input :value
    end
    f.actions
  end

  filter :name, label: 'Название'


end

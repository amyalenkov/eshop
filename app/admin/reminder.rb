ActiveAdmin.register Reminder do

  menu label: 'Напоминалка'

  permit_params :name, :value, :start_date, :stop_date, :turn_on

  config.per_page = 30

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :value
      f.input :start_date, :as => :datepicker
      f.input :stop_date, :as => :datepicker
      f.label 'Включить сообщение: '
      f.check_box :turn_on
    end
    f.actions
  end

  index :title => 'Напоминалка' do
    selectable_column
    column 'Название', :name
    column 'Текст', :value
    column 'Дата начала', :start_date
    column 'Дата окончания', :stop_date
    column 'Включить сообщение', :turn_on
    actions
  end


end

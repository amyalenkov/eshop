ActiveAdmin.register Reminder do

  menu label: 'Напоминалка'

  permit_params :name, :value, :start_date, :stop_date

  config.per_page = 30

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :value
      f.input :start_date, :as => :datepicker
      f.input :stop_date, :as => :datepicker
    end
    f.actions
  end

  index :title => 'Напоминалка' do
    selectable_column
    column 'Название', :name
    column 'Текст', :value
    column 'Дата начала', :start_date
    column 'Дата окончания', :stop_date
    actions
  end


end

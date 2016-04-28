ActiveAdmin.register CalendarDate do

  permit_params :name, :start_time

  config.per_page = 30

  form do |f|
    f.inputs 'Edit date' do
      f.input :name
      f.input :start_time, as: 'Just_datetime_picker'
    end
    f.actions
  end
end

ActiveAdmin.register CalendarDate do

  permit_params :name, :time, :date, :updated_at

  config.per_page = 30

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :time
      f.input :date, :as => :datepicker
    end
    f.actions
  end


end

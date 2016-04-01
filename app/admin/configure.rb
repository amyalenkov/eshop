ActiveAdmin.register Configure do

  permit_params :name, :value, :day_of_week, :time

  config.per_page = 30

  form do |f|
    f.inputs 'Edit Main Order' do
      f.input :day_of_week, as: :select, collection: Configure.day_of_weeks
      f.input :time
      f.input :value
    end
    f.actions
  end


end

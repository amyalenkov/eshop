ActiveAdmin.register DateForOrder do

  menu label: 'Даты для заказа'

  permit_params :name, :date, :description

  config.per_page = 30

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :date
      f.input :description
    end
    f.actions
  end

end

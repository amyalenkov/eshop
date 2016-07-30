ActiveAdmin.register MetaTag do

  menu label: 'Мета-теги'

  permit_params :name, :title, :description

  config.per_page = 30

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :title
      f.input :description
    end
    f.actions
  end

end

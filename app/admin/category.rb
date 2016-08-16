ActiveAdmin.register Category, :as => 'All Categories' do

  menu label: 'Категории'

  permit_params :name, :is_leaf

  config.per_page = 30

  filter :name

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :logo_image
      f.input :slug
      f.input :total_count_products
      f.input :sid
      f.input :is_leaf
      f.input :level
      f.input :parent_id
      f.input :path, :as => :string
    end
    f.actions
  end

end

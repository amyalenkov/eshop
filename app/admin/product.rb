ActiveAdmin.register Product do

  menu label: 'Товары'

  config.per_page = 30

  filter :id
  filter :name
  filter :sid

  permit_params :name, :title, :description

  form do |f|
    f.inputs 'Edit' do
      f.input :name
      f.input :description
      f.input :subcategory
      f.input :depth
      f.input :width
      f.input :height
      f.input :sid
      f.input :k_min, as: :check_boxes
      f.input :is_hit, as: :check_boxes
      f.input :min_qty
      f.input :balance_text
      f.input :box_size_text
      f.input :materials_text
      f.input :size_text
      f.input :unit
      f.input :image
      f.input :price
      f.input :weight
      f.input :certificate_type
      f.input :box_type
    end
    f.actions
  end
end

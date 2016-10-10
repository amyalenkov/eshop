ActiveAdmin.register Row do
  menu label: 'Ряды'
  config.per_page = 30

  # permit_params :current_count, :state, :description

  form do |f|
    f.inputs 'Edit' do
      f.input :current_count
      f.input :state
      f.input :product_id
      f.input :min_count
      f.input :main_order_id
    end
    f.actions
  end

end
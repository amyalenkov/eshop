ActiveAdmin.register Meeting do

  permit_params :description, :main_order_id, :meeting_date, :registered_time

  config.per_page = 30

  filter :description

  index do
    selectable_column
    column :id
    column :description
    column :main_order
    column :meeting_date
    column :registered_time
    actions
  end

  form do |f|
    f.inputs 'Edit Main Order' do
      f.input :main_order, as: :select, collection: MainOrder.where(state: MainOrder.states[:paid]).map{ |tech|  [tech.id.to_s+'-'+tech.state.to_s, tech.id] }
      f.input :meeting_date
      f.input :registered_time
      f.input :description
    end
    f.actions
  end

end

ActiveAdmin.register Meeting do

  menu label: 'Встречи'

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
    MainOrder.where(state: MainOrder.states[:paid]).map{ |tech|  Rails.logger.info([tech.id.to_s+'-'+tech.state.to_s, tech.id]) }

    f.inputs 'Edit Main Order' do
      f.input :main_order, as: :select, collection: MainOrder.where(state: MainOrder.states[:paid]).map{ |tech|  [tech.id.to_s+'-'+tech.state.to_s, tech.id] }
      f.input :meeting_date, :as => :datepicker
      # f.input :registered_time, :as => :time_picker
      f.input :registered_time, :as => :datetime_picker, format: 'YYYY-MM-DD HH:mm:ss.ffffff'
      f.input :description
      # "registered_time"=>"2016-07-22T10:53:06",
    end
    f.actions
  end

end

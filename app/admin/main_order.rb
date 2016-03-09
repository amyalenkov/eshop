ActiveAdmin.register MainOrder do

  config.per_page = 30

  filter :state

  permit_params :state

  form do |f|
    f.inputs 'Edit Main Order' do
      f.input :state, as: :select, collection: MainOrder.states.keys
    end
    f.actions
  end

end

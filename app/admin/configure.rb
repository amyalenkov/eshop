ActiveAdmin.register Configure do

  permit_params :name, :value

  config.per_page = 30

end

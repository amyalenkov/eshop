ActiveAdmin.register Meeting do

  permit_params :description, :active_admin

  config.per_page = 30

  filter :description

end

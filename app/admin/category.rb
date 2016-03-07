ActiveAdmin.register Category, :as => 'All Categories' do

  config.per_page = 30

  filter :name

end

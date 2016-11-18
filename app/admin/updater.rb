ActiveAdmin.register_page "updateForPrice" do

  menu label: 'обновление продуктов'

  content :title => 'обновление продуктов' do
    render partial: 'update_for_price'
  end

  controller do
    def index
      @categories = Category.where(level: 1).order(:name)
      @update_products = UpdateProduct.all
    end
  end

end
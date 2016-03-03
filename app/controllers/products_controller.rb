class ProductsController < ApplicationController

  def index
    if request.url.to_s.include? '/category/'
      category = Category.find_by_name params[:name]
      @subcategories = Subcategory.where :category_id => category.id
      @products = Product.includes(:subcategory).joins(:product_pictures).references(@subcategories).page(params[:page])
    elsif request.url.to_s.include? '/subcategory/'
      subcategory = Subcategory.find_by_name params[:name]
      @subcategories = Subcategory.where :category_id => subcategory.id
      @products = Product.includes(:subcategory).joins(:product_pictures).
          references(@subcategories).page(params[:page])
    else
      @products = Product.all.page(params[:page])
    end
  end

  def show
    @product = Product.find_by_id params[:id]
  end

  def search_ajax
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 25
    render json: @search_products.to_json
  end

  def search
    @search_products  = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                              :page => params[:page], :per_page => 25

  end
end

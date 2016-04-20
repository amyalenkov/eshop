class ProductsController < ApplicationController

  def index
    subcategory = Category.find_by_name params[:name]
    @subcategories = subcategory.children
    if subcategory.is_leaf?
      @products = Product.where(subcategory_id: subcategory.sid).page(params[:page])
    else
      all_sid = Array.new
      subcategory.descendants.where(is_leaf: true).each do |sub|
        all_sid.push sub.sid
      end
      @products = Product.where(subcategory_id: all_sid).page(params[:page])
    end
  end

  def show
    @product = Product.find_by_id params[:id]
    @alike_products = Product.where(subcategory: @product.subcategory).limit(50).order("RANDOM()")
    current_user.add_last_product @product
  end

  def search_ajax
    @search_products = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                             :page => params[:page], :per_page => 25
    render json: @search_products.to_json
  end

  def search
    @search_products = ThinkingSphinx.search params[:search], classes: [Product], :star => true,
                                             :page => params[:page], :per_page => 25
  end

end
class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    Favorite.create product_id: params[:product_id], user_id: current_user.id
    product_id = params[:product_id]
    count = 0
    @product = Product.find_by_id product_id
    unless current_user.product_in_cart? product_id
      cart_item = CartItem.new
      cart_item.product_id = @product.id
      cart_item.count = count
      cart_item.total_price = count * @product.get_price
      cart_item.user_id = current_user.id
      cart_item.save!
    end
  end

  def destroy
    favorite = Favorite.find_by id: params[:id]
    @product = Product.find_by_id favorite.product_id
    favorite.destroy!
  end

  def index
    @favorites = current_user.favorites
  end

  private

  def get_product
    @product = Product.find_by_id params[:product_id]
  end

end

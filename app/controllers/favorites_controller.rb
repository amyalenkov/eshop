class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    Favorite.create product_id: params[:product_id], user_id: current_user.id
    get_product
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

class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    Favorite.create favorite_params
    get_product
  end

  def destroy
    favorite = Favorite.find_by favorite_params
    favorite.destroy!
    get_product
  end

  def index
    @favorites = current_user.favorites
  end

  private

  def favorite_params
    params.require(:favorite).permit(:product_id, :user_id)
  end

  def get_product
    @product = Product.find_by_id params[:favorite][:product_id]
  end

end

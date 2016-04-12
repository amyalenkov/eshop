class Product < ActiveRecord::Base

  has_many :cart_items
  has_many :product_params
  has_many :product_pictures
  has_many :comments
  has_many :favorites

  belongs_to :subcategory

  ratyrate_rateable 'rating'

  def get_row
    Row.find_by(product_id: id, state: [Row.states[:full], Row.states[:not_full]])
  end

  def get_min_sale
    result = /\d+/.match min_qty.to_s
    result[0].to_i
  end

  def get_favorite user
    Favorite.find_by(user_id: user.id, product_id: id)
  end

end

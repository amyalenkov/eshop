class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  ratyrate_rater

  has_many :cart_items
  has_many :orders
  has_many :comments
  has_many :favorites

  def product_in_cart? product_id
    cart_item = cart_items.find_by(product_id: product_id)
    if cart_item.nil?
      false
    else
      true
    end
  end

  def get_cart_items_size
    if cart_items.nil?
      0
    else
      cart_items.length
    end
  end

  def get_cart_items_in_rows
    cart_items.where.not(row_id: nil)
  end

  def get_meetings
    orders.where.not(meeting_id: nil)
  end

  def get_current_order
    Order.find_by user_id: id, state: Order.states[:in_progress]
  end

  def is_favorite_product? product_id
    favorite = Favorite.find_by user_id: id, product_id: product_id
    if favorite.nil?
      return false
    else
      return true, favorite
    end
  end

end

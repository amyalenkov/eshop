class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :cart_items
  has_many :orders
  has_many :payments

  def product_in_cart? product_id
    cart_item = cart_items.find_by(product_id: product_id, state: CartItem.states[:in_cart])
    if cart_item.nil?
      false
    else
      true
    end
  end

  def get_all_cart_items_for_state state
    cart_items.where :state => state
  end

  def get_cart_items_in_rows
    cart_items.where.not(row_id: nil)
  end

end

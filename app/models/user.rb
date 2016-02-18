class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :cart_items

  def contains_product_in_cart? product_id
    if cart_items.find_by_product_id(product_id).nil?
      true
    else
      false
    end
  end

end

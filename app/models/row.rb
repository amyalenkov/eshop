class Row < ActiveRecord::Base

  enum state: [:not_full, :full]

  has_many :cart_items

  belongs_to :product
  
end

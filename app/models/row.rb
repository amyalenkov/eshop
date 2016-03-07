class Row < ActiveRecord::Base

  enum state: [:not_full, :full]

  belongs_to :product

  has_many :row_items
  
end

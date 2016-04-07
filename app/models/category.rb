class Category < ActiveRecord::Base
  has_ltree_hierarchy
  has_many :subcategories
end

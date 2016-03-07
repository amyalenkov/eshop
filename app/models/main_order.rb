class MainOrder < ActiveRecord::Base

  enum state: [:current, :stopped, :arrived]

  has_many :orders

  has_many :meetings

end

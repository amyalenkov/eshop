class MainOrder < ActiveRecord::Base

  enum state: [:current, :stopped, :arrived]

  has_many :orders

  has_many :meetings

  has_many :rows

  def get_current_rows
    main_order = MainOrder.find_by state: MainOrder.states[:current]
    main_order.rows
  end
end

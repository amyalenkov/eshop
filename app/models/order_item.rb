class OrderItem < ActiveRecord::Base
  enum state: [:in_progress,
               :reserved, :refusing_after_not_full_row,
               :bill, :refusing_after_reserved,
               :paid,:refusing_after_bill,
               :refund,:refunded]

  belongs_to :product
  belongs_to :order
  belongs_to :row


  def get_row_after_stop
    Row.find_by product: product, state: [Row.states[:reserved],Row.states[:refusing_after_reserved],
                                          Row.states[:bill],Row.states[:refusing_after_bill],Row.states[:paid]]
  end


end

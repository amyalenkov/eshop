namespace :my do

  desc 'stop task'
  task :stop_task => :environment do
    p 'stop task'
    main_order = MainOrder.find_by_state MainOrder.states[:current]
    main_order.stopped!
    MainOrder.create state: MainOrder.states[:current]
    main_order.orders.each do |order|
      order.stopped!
      order.order_items.each do |order_item|
        row = order_item.row
        CartItem.create(product_id: order_item.product_id, count: order_item.count,
                        user_id: order.user_id) if row.not_full?

        if row.not_full?
          order_item.refusing_after_not_full_row!
        elsif row.full? || row.reserved?
          order_item.reserved!
        end
      end
    end
    rows = Row.where state: Row.states[:not_full]
    rows.each do |row|
      row.row_comments.each do |row_comment|
        row_comment.destroy!
      end
      row.destroy!
    end
    full_rows = Row.where state: Row.states[:full]
    full_rows.each do |row|
      row.reserved!
    end
  end

  desc 'check payment task'
  task :check_payment_task => :environment do
    p 'check payment task'
    main_order = MainOrder.find_by_state MainOrder.states[:stopped]
    main_order.paid!
    orders = main_order.orders
    orders.each do |order|
      unless order.paid?
        order.not_paid!
        order.order_items.each do |order_item|
          order_item.refusing_after_bill!
        end
      end
    end

    rows = Row.where(state: Row.states[:bill])
    rows.each do |row|
      row.order_items.each do |order_item|
        if order_item.refusing_after_bill?
          row.current_count = row.current_count - order_item.count
          if row.current_count < row.min_count
            row.state = Row.states[:refusing_after_bill]
            break
          end
        end
      end
      row.save!
      row.paid! if row.full?
      row.refusing_after_bill! if row.not_full?
      #возврат денег
      if row.refusing_after_bill?
        row.order_items.each do |order_item|
          order_item.refund! if order_item.paid?
        end
      end
    end
  end

end
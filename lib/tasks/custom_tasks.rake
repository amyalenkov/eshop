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
          unless row.product.k_min?
            order_item.reserved!
          else
            multiple = row.current_count / row.product.min_qty
            row.current_count = multiple * row.product.min_qty
            row.save!
            if multiple * row.product.min_qty == row.current_count
              row.order_items.each do |order_item|
                order_item.reserved!
              end
            else
              reserved = multiple * row.product.min_qty
              sorted_order_items = row.order_items.order(count: :desc)
              sorted_order_items.each do |order_item|
                reserved = reserved - order_item.count
                if reserved >= 0
                  order_item.state = OrderItem.states[:reserved]
                  order_item.save!
                else
                  if order_item.count > (reserved).abs
                    order_item.state = OrderItem.states[:reserved]
                    order_item.count = (reserved).abs
                    order_item.save!
                    CartItem.create(product_id: order_item.product_id, count: order_item.count - (reserved).abs,
                                    user_id: order.user_id)
                  else
                    CartItem.create(product_id: order_item.product_id, count: order_item.count,
                                    user_id: order.user_id)
                  end
                end
              end
            end
          end
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
    p 'end stop task'
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
        current_count = row.current_count
        if order_item.refusing_after_bill?
          current_count = current_count - order_item.count
          if current_count < row.min_count
            row.not_full_after_bill!
            break
          end
        end
      end
      row.paid! if row.bill?
      #возврат денег
      # if row.refusing_after_bill?
      #   row.order_items.each do |order_item|
      #     order_item.refund! if order_item.paid?
      #   end
      # end
    end
  end

  desc 'count_product_task'
  task :count_product_task => :environment do
    require "#{Rails.root}/lib/api/product"
    p 'count_product_task'
    count = 0
    OrderItem.find_each do |product|
      count += 1
      product_sima = ProductSima.new 'https://www.sima-land.ru/api/v2/'
      product_new = product_sima.get_product_by_sid Product.find_by_id(product.product_id).sid

      if product_new && product_new['balance_text']
        puts '---------------------------'
        puts count

        product = Product.find_by_id product.product_id
        product.balance_text = product_new['balance_text']
        product.save

      end
    end
  end

end
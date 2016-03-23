class StaticPagesController < ApplicationController

  def index
  end

  def order_call
    name_order = params[:name]
    phone_number_order = params[:phone]
    email_order = params[:email]
    message_order = params[:message]

    TestSender.send_email(name_order, phone_number_order, email_order, message_order).deliver
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

end

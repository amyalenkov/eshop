class StaticPagesController < ApplicationController

  def index
    @categories = Category.where level: 1
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

  def category_list
    @categories = Category.where level: 1
    @category = Category.find_by_id params[:name]
    # all_subcategories,@subcategories = get_subs(category.id)
    @subcategories = @category.children
  end

  # def questions
  #   @questions = Question.all
  # end

  private
  def get_subs id
    arr = Array.new
    get_subs_requrs id, arr
  end

  def get_subs_requrs id, arr
    new_arr = get_subs_by_id id
    first_arr = new_arr
    unless new_arr.size == 0
      (arr << new_arr).flatten!
      new_arr.each do |sub|
        get_subs_requrs sub.id, arr
      end
    end
    return arr, first_arr
  end

  def get_subs_by_id id
    Subcategory.where :category_id => id
  end
end

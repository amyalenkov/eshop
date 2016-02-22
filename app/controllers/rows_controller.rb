class RowsController < ApplicationController

  before_action :authenticate_user!, only: :create

  def index
    @rows = Row.all
  end

  def show
    @row = Row.find_by_id params[:id]
  end

  def create
    @row = Row.new
    @row.current_count = params[:count]
    @row.product_id = params[:product_id]
    @row.save!
    redirect_to @row
  end

end

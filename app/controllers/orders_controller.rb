class OrdersController < ApplicationController
  before_action :load_order, only: [:show]

  def index; end

  def show; end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "controller.orders.order_not_exist"
    redirect_to orders_path
  end
end

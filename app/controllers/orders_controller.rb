class OrdersController < ApplicationController
  before_action :load_order, only: :show
  before_action :load_cart, only: %i(new create)

  def index; end

  def show; end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params
    if @order.save
      flash[:success] = t "controller.orders.create_order_success"
      session[:cart] = nil
      redirect_to root_path
    else
      flash[:danger] = t "controller.orders.create_order_errror"
      redirect_to root_path
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "controller.orders.order_not_exist"
    redirect_to orders_path
  end

  def load_cart
    @cart = current_cart
    flash[:danger] = t "controller.carts.cart_not_found" if @cart.nil?
  end
  
  def order_params
    params.require(:order).permit :status, :totalamount, :user_id, :giftcode_id
  end
end

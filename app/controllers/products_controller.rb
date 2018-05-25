class ProductsController < ApplicationController
  before_action :load_product, only: :show

  def index
    if params[:category].blank?
      @products = Product.by_status(:show).order_by_created.paginate page: params[:page],
        per_page: Settings.per_page_index
      @hot_trends = Product.hot_trend
    else
      @category = Category.find_by title: params[:category]
      @products =
        @category.products.by_status(:show).order_by_created.paginate page: params[:page],
          per_page: Settings.per_page_index if @category
    end
  end

  def show; end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "controller.products.pro_not_exist"
    redirect_to products_path
  end
end

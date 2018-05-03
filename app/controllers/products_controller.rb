class ProductsController < ApplicationController
  before_action :load_product, except: %i(new create index)
  before_action :map_category, only: %i(new edit create)

  def index
    if params[:category].blank?
      @products = Product.by_status(:show).order_by_created
    else
      @category = Category.find_by title: params[:category]
      @products = @category.products.by_status(:show).order_by_created if @category
    end
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      redirect_to product_path @product
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "controller.products.del_pro"
      redirect_to products_path
    else
      flash[:danger] = t "controller.products.del_pro_fail"
      redirect_to root_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:productname, :productcontent,
      :category_id, :image, :price, :discount, :onhand, :status, :author)
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "controller.products.pro_not_exist"
    redirect_to products_path
  end

  def map_category
    @categories = Category.all.map{|c| [c.title, c.id]}
  end
end

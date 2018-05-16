class Admin::ProductsController < Admin::AdminController
  before_action :require_admin
  before_action :load_product, except: %i(new create index)
  before_action :map_category, except: %i(index destroy)

  def index
    @products = Product.includes(:category).paginate page: params[:page], per_page: Settings.per_page_order_items
  end

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
      flash[:success] = t "controller.products.success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "controller.products.del_pro"
    else
      flash[:danger] = t "controller.products.del_pro_fail"
    end
    redirect_to admin_products_path
  end

  private

  def map_category
    @categories = Category.all.map{|c| [c.title, c.id]}
  end

  def product_params
    params.require(:product).permit :productname, :productcontent,
      :category_id, :image, :price, :discount, :onhand, :status, :author
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "controller.products.pro_not_exist"
    redirect_to products_path
  end
end
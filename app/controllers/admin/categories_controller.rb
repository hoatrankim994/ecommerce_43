class Admin::CategoriesController < Admin::AdminController
  before_action :require_admin
  before_action :load_category, except: %i(new create index)
  before_action :map_category, only: %i(new edit create update)

  def index
    @categories = Category.all.ordered_by_title.paginate(page: params[:page],
      per_page: Settings.per_page_order_items)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controller.category.success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "controller.category.success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controller.category.del_cate"
    else
      flash[:danger] = t "controller.category.del_cate_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def map_category
    @categories = Category.all.map{|c| [c.title, c.id]}
  end

  def category_params
    params.require(:category).permit(:title, :parent_id,
      :status, :catcontent)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "controller.category.cate_not_exist"
    redirect_to admin_categories_path
  end
end

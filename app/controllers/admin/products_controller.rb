class Admin::ProductsController < ApplicationController
  before_action :logged_in_user, :admin_user
  before_action :find_product, except: [:new, :create, :index]
  before_action :load_products, only: [:new, :edit, :index]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash.now[:notice] = t "product.create_notice"
      redirect_to admin_product_path @product
    else
      load_products
      flash.now[:danger] = t "product.create_alert"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update product_params
      flash[:notice] = t "product.update_notice"
      redirect_to @product
    else
      load_products
      flash.now[:danger] = t "product.update_alert"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "product.destroy"
      redirect_to root_url
    end
  end

  def index
    @selected_classify = params[:classify]
    @selected_category = params[:category]
    @selected_sorted_by = params[:sorted_by]
    @products = Product.filter @selected_classify, @selected_category, 
      @selected_sorted_by
    @products = @products.paginate page: params[:page], per_page: 6   
  end

  private
  def product_params
    params.require(:product).permit :name, :content, :picture_link, :price,
      :classify, :category_id, :quantity
  end

  def find_product
    @product = Product.find_by_id params[:id]
    if @product.nil?
      flash[:danger] = t "product.nil"
      redirect_to root_url
    end
  end

  def load_products
    @categories = Category.all
    @classify_selects =
      Product.classifies.map{|key, value| [I18n.t("classify.#{key}"), value]}
    @sorted_by_selects = [[I18n.t("product.sort_by_Aphabet"), "name DESC"], 
      [I18n.t("product.sort_by_sprice_asc"), "price ASC"], 
      [I18n.t("product.sort_by_sprice_desc"), "price DESC"], 
      [I18n.t("product.sort_by_rating_asc"), "rating ASC"], 
      [I18n.t("product.sort_by_rating_desc"), "rating DESC"]] 
    @category_selects = @categories.collect{|cat| [cat.name, cat.id]}
  end
end

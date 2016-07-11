class Admin::ProductsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :find_product, except: [:new, :create]
  before_action :load_products, only: [:new, :edit]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash.now[:notice] = t "product.create_notice"
      redirect_to @product
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
    @product_selects =
      Product.classifies.map{|key, _| [I18n.t("classify.#{key}"), key]}
    @category_selects = @categories.collect{|cat| [cat.name, cat.id]}
  end
end

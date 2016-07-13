class ProductsController < ApplicationController
  before_action :logged_in_user

  def index
    load_products
    @selected_classify = params[:classify]
    @selected_category = params[:category]
    @selected_sorted_by = params[:sorted_by]
    @products = Product.filter @selected_classify, @selected_category, 
      @selected_sorted_by
    @products = @products.paginate page: params[:page], per_page: 6   
  end

  def show
    @product = Product.find_by_id params[:id]
    if @product.nil?
      flash[:danger] = t "product.nil"
      redirect_to :back
    end 
    @comments = @product.comments.paginate page: params[:page]
    @comment ||= @product.comments.new
  end

  private
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

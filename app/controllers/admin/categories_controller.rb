class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @category = Category.new
    @categories = Category.paginate page: params[:page]
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.success"
    else
      flash[:danger] = t "category.fail"
    end
    redirect_to admin_categories_path 
  end
  
  def destroy
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t "category.nil"
      redirect_to admin_categories_path
    end
    if @category.destroy
      flash[:success] = t "category.destroy"
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end

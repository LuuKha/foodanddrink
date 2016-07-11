class ProductsController < ApplicationController
  before_action :logged_in_user

  def index
    @products = Product.all
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
end

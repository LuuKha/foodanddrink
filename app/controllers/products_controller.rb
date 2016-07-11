class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_id params[:id]
    if @product.nil?
      flash[:danger] = t "product.nil"
      redirect_to root_url
    end
  end
end

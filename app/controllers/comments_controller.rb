class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @product = Product.find_by_id params[:product_id]
    if @product.nil?
      flash[:danger]= t "product.nil"
      redirect_to :back
    end
    @comment = current_user.comments.build comment_params
    @comment.product_id = @product.id
    if @comment.save
      flash[:success] = t "comment.save"   
    else
      flash[:danger] = t "comment.unsave"
    end
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end
end

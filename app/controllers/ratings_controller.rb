class RatingsController < ApplicationController
  before_action :logged_in_user
  before_action :check_rating, only: [:create, :update]
  # after_action :update_rating, only: [:create, :update]

  def update
    @rating.update rating_params
    flash[:success] = t "rating.updated"
    t_rating = @product.ratings.average :rating_score
    @product.update_attributes rating: t_rating
    redirect_to :back
  end

  def create
      @rating = current_user.ratings.create rating_params
      @rating.product_id = @product.id
      if @rating.save
        flash[:success] = t "rating.success"      
      else
        flash[:danger] = t "rating.fail"
      end
      t_rating = @product.ratings.average :rating_score
      @product.update_attributes rating: t_rating
      redirect_to :back
  end

  private
  def rating_params
    params.require(:rating).permit :rating_score    
  end

  def check_rating
    @product = Product.find_by_id params[:product_id]
    if @product.nil?
      flash[:danger]= t "product.nil"
      redirect_to :back
    end
    @rating = Rating.find_by_product_id_and_user_id @product.id, current_user.id
    if @rating.present?
      update
    end
  end
end

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "user.nil"
      redirect_to root_url
    end
  end

  def index
    @products = Product.paginate page: params[:page] 
  end

  def edit
  end

  def update
    if @user.update_attributes user_params 
      flash[:success] = t "user.update-success"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end

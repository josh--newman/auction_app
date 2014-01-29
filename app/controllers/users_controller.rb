class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @items = Item.where("user_id = ?", @user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      # flash[:success] = "Welcome to JBay!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    @user.destroy
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

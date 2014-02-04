class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :edit, :update]
  before_action :check_user_session, only: [:new]
  before_action :check_show_user, only: [:index, :show]
  before_action :check_edit_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @items = Item.where("user_id = ?", @user.id)
    @bids = Bid.where("user_id = ?", @user.id).group(:item_id)
    # @closed_items = []
    # @bids.each do |bid|
    #   @closed_items.push(bid.item.where("finish_time < ?", Time.now))
    # end
    # @winning_bids = Bid.find_all_winning_bids
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: "Welcome to JBay!"
    else
      render action: 'new', notice: "Couldn't create your profile"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully"
    else
      render action: 'edit'
    end
  end

  def destroy
    sign_out
    @user.destroy
    redirect_to users_path, notice: "User deleted"
  end

  private

    def check_show_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in"
      end
    end

    def check_edit_user
      unless signed_in? && (@user.id == current_user.id || current_user.admin)
        store_location
        redirect_to signin_path, notice: "Please sign in"
      end
    end

    def check_user_session
      redirect_to current_user, notice: "You're already signed in" if signed_in?
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end

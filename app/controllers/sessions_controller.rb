class SessionsController < ApplicationController
  before_action :check_user_session, only: [:new, :create]
  before_action :check_destroy_session, only: [:destroy]

  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      render 'new', notice: "Invalid username/password combination"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

    def check_user_session
      redirect_to current_user, notice: "You already have an account" if signed_in?
    end

    def check_destroy_session
      redirect_to signin_path, notice: "Please sign in" unless signed_in?
    end
end

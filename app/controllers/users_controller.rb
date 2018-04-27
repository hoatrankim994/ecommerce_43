class UsersController < ApplicationController
  before_action :load_user, only: %i(show)

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "controller.users.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controller.users.users_not_exist"
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :phone, :gender, :avartar)
  end
end

class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザ登録が完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :user_profile)
  end
  
end

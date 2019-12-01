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
      login(@user.email, @user.password)
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザ登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
   @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィールが更新されました。'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    
    if @user.destroy
      flash[:success] = '退会しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '退会に失敗しました。'
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :user_profile)
  end
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  
end

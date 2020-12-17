class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show edit update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, success: 'ユーザー登録しました'
    else
      flash.now[:danger] = 'ユーザー登録できませんでした'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: 'ユーザー情報を更新しました'
    else
      flash.now[:danger] = 'ユーザー情報更新に失敗しました'
      render :edit
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

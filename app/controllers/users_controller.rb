class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  def new; end

  def create
    @user = login(params[:name], params[:email], params[:password])

    if @user
      redirect_back_or_to(:users, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      redirect_to schedules_path
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end

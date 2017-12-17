class SessionsController < ApplicationController

  before_action :prevent_logged_in_user_access, except: :destroy
  before_action :prevent_unauthorized_user_access, only: :destroy

  def new
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      login(user)
      redirect_to root_path, notice: 'Logged in'
    else
      flash.now[:notice] = 'Invalid username / password combination'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out'
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      render :show
    else
      flash.now[:errors] = @user.errors.full_messages
      @user = User.new(user_params)
      render :new
    end
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def show
    @user = User.find(params[:id])
    if @user
      render :show
    else
      flash[:errors] << @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

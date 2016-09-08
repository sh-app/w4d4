class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.is_password?(params[:user][:password])
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

end

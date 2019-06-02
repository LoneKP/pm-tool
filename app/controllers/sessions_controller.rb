class SessionsController < ApplicationController
  def new
    
  end

  def create_log_in
    @user = User.find_by_email(params[:session][:email])
    @organisation = @user&.organisation
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to dashboard_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Something went wrong"
      render "new"
    end
  end

  def create_set_up
    @user = User.find(params[:session][:user_id])
    @organisation = @user.organisation
    if log_in(@user)
      redirect_to dashboard_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Something went wrong"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

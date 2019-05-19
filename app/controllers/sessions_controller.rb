class SessionsController < ApplicationController
  def new
  end

  def create_log_in
    @user = User.find_by_email(params[:session][:email])
    @organisation = @user.organisation
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      fetch_harvest_projects
      redirect_to dashboard_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def create_set_up
    @user = User.find(params[:session][:user_id])
    @organisation = @user.organisation
    if log_in(@user)
      fetch_harvest_projects
      redirect_to dashboard_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Something went wrong"
      render "new"
    end
  end

  def fetch_harvest_projects
    if @organisation.has_harvest_integration?
      update_access_token_if_it_has_expired
      FetchProjects.new(@user).update_projects
    end
  end

  def update_access_token_if_it_has_expired
    if @organisation.harvest_access_token_expired?
      UpdateAccessToken.new(@organisation).update_access_token
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    @organisation = @user.organisation

    if @user && @user.authenticate(params[:session][:password])
      update_access_token_if_it_has_expired
      log_in_and_fetch_projects
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def log_in_and_fetch_projects
    session[:user_id] = @user.id
    FetchProjects.new(@user).update_projects
    redirect_to dashboard_url, notice: "Logged in!"
  end

  def update_access_token_if_it_has_expired
    UpdateAccessToken.new(@organisation).update_access_token if @organisation.harvest_integration.access_token_expiration_time < Time.now
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

class SessionsController < ApplicationController
  def new; end

  def create
    
    @code = params[:code]
    @user = HarvestAccess.new(@code).call
    session[:user_id] = @user.id
    redirect_to dashboard_url

    # put this in worker when it works
    FetchProjects.new(@user).update_projects
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end

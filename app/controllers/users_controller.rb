class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @organisation = Organisation.find(params[:organisation_id])
    @user.organisation = @organisation
    if @user.save
      redirect_to user_invite_colleagues_path(@user)
    else
      render "new"
    end
  end

  def new
    @user = User.new
  end

  def invite_colleagues; end

  def done; end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end

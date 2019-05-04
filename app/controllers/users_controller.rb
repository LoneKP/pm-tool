class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @organisation = Organisation.find(params[:organisation_id])
    @user.organisation = @organisation
    if @user.save
      redirect_to new_user_invitation_path(@user)
    else
      render "new"
    end
  end

  def new
    @user = User.new
  end

  def new_from_invitation
    @user = User.new
    @token = params[:invitation_token]
    @invitation = Invitation.where(token: @token).last
    @organisation = Organisation.find(params[:organisation_id])
    if User.exists?(email: @invitation.email)
      redirect_to root_path, turbolinks: false, alert: "It seems that you already have a user!"
    end
  end

  def create_from_invitation
    @user = User.new(user_params)
    @organisation = Organisation.find(params[:organisation_id])
    @user.organisation = @organisation
    @token = params[:invitation_token]
    @invitation = Invitation.where(token: @token)
    if @user.save
      redirect_to root_path
    else
      render "new_from_invitation"
    end
  end

  def done; end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end

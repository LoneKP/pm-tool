class InvitationsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @invitation = Invitation.new(invitation_params)
    @organisation = @user.organisation
    @invitation.save
    if @invitation.save
      redirect_to user_done_path(@user)
    else
      render "new"
    end
  end

  def new
    @user = User.find(params[:user_id])
    @organisation = @user.organisation
    @invitation = Invitation.new
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :token, :user_id, :organisation_id)
  end
end

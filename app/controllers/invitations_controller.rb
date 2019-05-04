class InvitationsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @invitation = Invitation.new(invitation_params)
    @organisation = @user.organisation
    @invitation.save
    if @invitation.save
      redirect_to user_done_path(@user)
      UserMailer.invitation_email(@invitation, organisation_new_from_invitation_url(:invitation_token => @invitation.token, :organisation_id => @invitation.organisation.id)).deliver_later
    else
      redirect_to root_path
    end
  end

  def invitation_token_key
    User.find(params[:user_id])
    @invitation = Invitation.find(params[:invitation_token])
    @organisation = @invitation.organisation
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

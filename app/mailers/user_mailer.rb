class UserMailer < ApplicationMailer
  def invitation_email(invitation, url)
    @invitation = invitation
    @url = url
    mail(to: @invitation.email, subject: "You have been invited to Prjectio")
  end

  def welcome_email
  end

  def forgot_password_email
  end
end

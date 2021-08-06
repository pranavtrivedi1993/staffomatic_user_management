class UserMailer < ApplicationMailer

  def archive_unarchive_email(user)
    @user = user
    @subject = @user.archived? ? "Archived" : "Unarchived"
    mail(to: @user&.email, subject: @subject)
  end

  def destroy_email(user)
    @user = user
    subject = "Destroyed"
    mail(to: @user&.email, subject: subject)
  end

end
class ParentMailer < ApplicationMailer
  def send_new_account_mail
    @user = params[:user]
    @token = params[:token]

    mail(to: @user.email, subject: 'Confirm')
  end
end

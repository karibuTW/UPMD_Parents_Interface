class ParentMailer < ApplicationMailer
  def send_new_account_mail
    @user = params[:user]
    @token = params[:token]
    @password = params[:password]
    @donated = params[:donated] || false
    # mail(to: @user.email, subject: 'Please validate your email / Merci de valider votre adresse email / Vui lòng xác nhận email của bạn')
    mail(to: 'dudumomo+a@gmail.com', subject: 'Please validate your email / Merci de valider votre adresse email / Vui lòng xác nhận email của bạn')
  end

  def send_donation_mail
    @user = params[:user]

    mail(to: 'dudumomo+a@gmail.com', subject: t('mails.subjects.donation'))
    # mail(to: @user.email, subject: t('mails.subjects.donation'))
  end

  def send_payment_mail
    @user = params[:user]

    mail(to: 'dudumomo+a@gmail.com', subject: t('mails.subjects.payment_confirmation'))
    # mail(to: @user.email, subject: t('mails.subjects.payment_confirmation'))
  end
end

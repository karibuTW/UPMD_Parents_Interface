class AdminMailer < ApplicationMailer
  def send_data_pulled_mail
    @email = params[:email]
    mail(to: params[:email], subject: "Data from HelloAsso fetched successfully")
  end

  def debug_mail
    @data = params[:data]
    mail(to: 'aniketmail669@gmail.com', subject: 'HelloAsso webhook')
  end
end

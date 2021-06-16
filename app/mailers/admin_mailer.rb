class AdminMailer < ApplicationMailer
  def send_data_pulled_mail
    @email = params[:email]
    mail(to: params[:email], subject: "Data from HelloAsso fetched successfully")
  end
end

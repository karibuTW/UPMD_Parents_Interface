class AdminMailer < ApplicationMailer
  def send_data_pulled_mail
    mail(to: params[:email], subject: "Data from HelloAsso fetched successfully")
  end
end

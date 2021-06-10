class PullHelloassoDataJob < ApplicationJob
  queue_as :default
  after_perform :send_email

  def perform(email)
    @email = email
    Helloasso::Order.process_orders
  end

  def send_email
    AdminMailer.with(email: @email).send_data_pulled_mail.deliver_later
  end
end

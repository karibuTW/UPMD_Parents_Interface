class PullHelloassoDataJob < ApplicationJob
  queue_as :default
  # after_perform :send_email  removed

  def perform(email=nil)
    @email = email
    Helloasso::Order.process_orders
  end

  def send_email
    AdminMailer.with(email: @email).send_data_pulled_mail.deliver_later if @email.present?
  end
end

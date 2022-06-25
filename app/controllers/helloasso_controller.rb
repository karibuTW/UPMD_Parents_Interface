class HelloassoController < ApplicationController
  skip_before_action :verify_authenticity_token, :switch_locale

  def webhook
    begin
      if params[:eventType] == 'Order'
        Helloasso::Order.process_order(params[:data])
      else
        PullHelloassoDataJob.perform_later
      end
    rescue Exception => e
      puts e
      # PullHelloassoDataJob.perform_later
    end
    # 554
    head :ok
  end
end

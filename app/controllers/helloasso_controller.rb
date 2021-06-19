class HelloassoController < ApplicationController
  def webhook
    p params
    begin
      if params[:eventType] == 'Payment'
        Helloasso::Order.process_order params[:data]
      end
    rescue
      PullHelloassoDataJob.perform_later "aniketmail669@gmail.com"
    end

    head :ok
  end
end

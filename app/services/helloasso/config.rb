module Helloasso
  class Config
    BASE_URL = "https://api.helloasso.com/v5"

    def self.get_orders_url(organization, form)
      "#{BASE_URL}/organizations/#{organization}/forms/Membership/#{form}/orders"
    end

    def self.get_order_by_order_no_url(order_no)
      "#{BASE_URL}/orders/#{order_no}"
    end

    def self.get_payment_by_payment_id_url(payment_id)
      "#{BASE_URL}/payments/#{payment_id}"
    end
  end
end
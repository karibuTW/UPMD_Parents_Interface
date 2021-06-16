# frozen_string_literal: true

module Helloasso
  class Order
    extend Auth
    def self.get_records(query)
      Auth.authenticate do |auth|
        auth.get(
          Config.get_orders_url(Setting.helloasso_organization_slug, Setting.helloasso_current_form_id), query: query
        )
      end
    end

    def self.get_order_by_order_no(order_no)
      Auth.authenticate do |auth|
        auth.get(
          Config.get_order_by_order_no_url(order_no)
        )
      end
    end

    def self.get_payment_by_id(payment_id)
      Auth.authenticate do |auth|
        auth.get(
          Config.get_payment_by_payment_id_url(payment_id)
        )
      end
    end

    def self.get_all_records
      get_records({ pageIndex: 1 })
    end

    def self.process_order(data)

      return if HelloassoOrder.exists? helloasso_order_id: data['id']

      payer = JSON.parse(get_order_by_order_no(data['id']).body)
      parent = Parent.find_by_email(payer.dig('payer', 'email'))
      if parent.nil?
        password = SecureRandom.hex(8)
        parent = Parent.new email: payer.dig('payer', 'email'),
                            first_name: payer.dig('payer', 'firstName'), last_name: payer.dig('payer', 'lastName'),
                            password: password, password_confirmation: password# , confirmed_at: Time.now.utc
        parent.skip_confirmation_notification!
        parent.save
        p parent.errors
        # ParentMailer.with(user: parent, token: parent.confirmation_token).send_new_account_mail.deliver_later
      end

      order = HelloassoOrder.create(parent: parent, amount_total: data.dig('amount', 'total'),
                                    amount_vat: data.dig('amount', 'vat'), form_slug: Setting.helloasso_current_form_id,
                                    amount_discount: data.dig('amount', 'discount'), helloasso_order_id: data['id'], date: data['date'])

      data['items'].to_a.each do |item|
        order_item = HelloassoOrderItem.create(helloasso_order: order, amount: item['amount'], order_item_type: item['type'],
                                               state: item['state'], discount_code: item.dig('discount', 'code'),
                                               discount_amount: item.dig('discount', 'amount'),
                                               price_category: item['priceCategory'], membership_card_url: item['membershipCardUrl'],
                                               cancelled: item['isCanceled'], order_item_id: item['id'], date: item['date'])
        if order_item.discount_code.present?
          order.update discount_code: DiscountCode.find_by_code(order_item.discount_code), confirmation: "NO"
        end
      end

      data['payments'].to_a.each do |payment|

        payment = HelloassoPayment.create(helloasso_order: order, amount_tip: payment['amountTip'],
                                          cash_out_state: payment['cashOutState'],
                                          payment_receipt_url: payment['paymentReceiptUrl'], fiscal_receipt_url: payment['fiscalReceiptUrl'],
                                          helloasso_payment_id: payment['id'], amount: payment['amount'],
                                          date: payment['date'], payment_means: payment['paymentMeans'], state: payment['state'],
                                          payment_type: payment['type'])
      end

    end

    def self.process_orders
      response = get_records({ withDetails: true, pageSize: 99_999_999 })
      cont = response['pagination']['continuationToken']
      response['data'].each do |data|
        process_order data
      end
      loop do
        response = get_records({ withDetails: true, continuationToken: response['pagination']['continuationToken'] })
        response['data'].to_a.each do |data|
          process_order data
        end
        break if cont == response['pagination']['continuationToken']

        cont = response['pagination']['continuationToken']
      end

      response
    end
  end
end

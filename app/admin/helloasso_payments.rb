ActiveAdmin.register HelloassoPayment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :helloasso_order_id, :amount_tip, :cash_out_state, :payment_receipt_url, :fiscal_receipt_url, :helloasso_payment_id, :amount, :date, :payment_means, :state, :payment_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:helloasso_order_id, :amount_tip, :cash_out_state, :payment_receipt_url, :fiscal_receipt_url, :helloasso_payment_id, :amount, :date, :payment_means, :state, :payment_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

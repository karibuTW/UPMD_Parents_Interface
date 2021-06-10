ActiveAdmin.register HelloassoOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :parent_id, :amount_total, :amount_vat, :amount_discount, :helloasso_order_id, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:parent_id, :amount_total, :amount_vat, :amount_discount, :helloasso_order_id, :date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  action_item :fetch_data do
    link_to "Fetch data from HelloAsso", fetch_data_admin_helloasso_orders_path
  end

  collection_action :fetch_data, method: :get do
    PullHelloassoDataJob.perform_later current_admin_user.email
    redirect_to admin_helloasso_orders_path, notice: "The job was succcessfully enqueued. You will be notified via email when it finishes."
  end
end

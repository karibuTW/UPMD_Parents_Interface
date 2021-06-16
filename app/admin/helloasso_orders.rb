# frozen_string_literal: true

ActiveAdmin.register HelloassoOrder do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :parent_id, :amount_total, :amount_vat, :amount_discount, :helloasso_order_id, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:parent_id, :amount_total, :amount_vat, :amount_discount, :helloasso_order_id, :date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  action_item :fetch_data do
    link_to 'Fetch data from HelloAsso', fetch_data_admin_helloasso_orders_path
  end

  action_item :export_csv do
    link_to 'Export CSV', admin_helloasso_orders_path(format: :csv)
  end

  collection_action :fetch_data, method: :get do
    PullHelloassoDataJob.perform_later current_admin_user.email
    redirect_to admin_helloasso_orders_path,
                notice: 'The job was succcessfully enqueued. You will be notified via email when it finishes.'
  end

  filter :parent
  filter :amount_total
  filter :amount_discount
  filter :form_slug
  filter :discount_code

  index download_links: [:csv] do
    selectable_column
    id_column
    column :parent
    column :amount_total
    column :amount_discount
    column :amount_vat
    column :helloasso_order_id
    column :date
    column :discount_code
    actions
  end

  csv do
    column('OrderID', humanize_name: false, &:helloasso_order_id)
    column :id
    column :amount_total
    column(:discount_code) { |o| o.discount_code.code if o.discount_code.present? }
    column :payment_method
    column(:first_name) { |o| o.parent.first_name }
    column(:last_name) { |o| o.parent.last_name }
    column :date
    column(:email) { |o| o.parent.email }
    column :attestation_url
  end
end

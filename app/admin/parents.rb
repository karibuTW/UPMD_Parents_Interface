# frozen_string_literal: true

ActiveAdmin.register Parent do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
                :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :password, :password_confirmation,
                :first_name, :last_name, :full_name, :phone_number, :address, :preferred_language, :mailing_list, :public_comment,
                children_attributes: %i[id _destroy first_name last_name full_name grade birth_date],
                secondary_parent_attributes: %i[id _destroy email first_name last_name full_name
                                                address preferred_language phone_number primary_parent_id],
                bus_services_attributes: %i[id year _destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :first_name, :last_name, :full_name, :phone_number, :address, :preferred_language, :mailing_list]
  #   permitted << :other if params[:action] == 'create' && current_parent.admin?
  #   permitted
  # end

  filter :email
  filter :first_name
  filter :last_name
  filter :full_name
  filter :mailing_list
  filter :children_grade_eq, as: :select, label: 'Grade of children', collection: Child.grades.keys.to_a
  filter :bus_services_year, as: :numeric, label: 'Has bus service for year'

  index download_links: false do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :full_name
    column :phone_number
    column :address
    column :preferred_language
    column :mailing_list
    column :new_bus_service?
    column :renewed_bus_service?
    column :paid_member?
    column :donated?
    actions
  end
  show do |parent|
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :full_name
      row :phone_number
      row :address
      row :preferred_language
      row :mailing_list
      row :new_bus_service?
      row :renewed_bus_service?
      row :paid_member?
      row :donated?
      row :public_comment
    end

    panel 'Secondary parent' do
      if parent.secondary_parent
        attributes_table_for parent.secondary_parent do
          row :id do |p|
            link_to p.id, admin_secondary_parent_path(p)
          end
          row :email
          row :first_name
          row :last_name
          row :full_name
          row :phone_number
          row :address
          row :preferred_language
        end
      else
        div do
          p 'No secondary parent'
        end
      end
    end

    panel 'Children' do
      table_for parent.children do
        column :id do |c|
          link_to c.id, admin_child_path(c)
        end
        column :first_name
        column :last_name
        column :full_name
        column :birth_date
        column :grade
      end
    end

    panel 'Bus registration' do
      table_for parent.bus_services do
        column :id do |b|
          link_to b.id, admin_bus_registration_path(b)
        end
        column :year
      end
    end
    active_admin_comments
  end
  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :full_name
      f.input :phone_number
      f.input :address
      f.input :preferred_language
      f.input :public_comment, as: :text

      f.has_many :secondary_parent, heading: 'Secondary Parent', allow_destroy: true, class: 'has-one' do |sp|
        sp.inputs :email, :first_name, :last_name, :full_name, :address, :phone_number, :preferred_language
      end

      f.has_many :children, allow_destroy: true, heading: 'Children' do |p|
        p.inputs :first_name, :last_name, :full_name, :grade
        p.input :birth_date, as: :date_picker
      end

      f.has_many :bus_services, allow_destroy: true, heading: 'Bus Services' do |p|
        p.inputs :year
      end
    end
    f.actions
  end
  controller do
    def scoped_collection
      super.includes(:children, :secondary_parent, :bus_services)
    end

    def update
      if params[:parent][:password].blank? && params[:parent][:password_confirmation].blank?
        params[:parent].delete('password')
        params[:parent].delete('password_confirmation')
      end
      super
    end
  end

  action_item :download_as_csv, only: [:index] do
    a(href: download_as_csv_admin_parents_path(q: params.to_unsafe_h[:q])) do
      'Download as csv'
    end
  end

  collection_action :download_as_csv, method: :get do
    # define your own headers
    csv_headers = ['Registration Date', 'Last Update', 'HelloAsso ID', 'Paid?', 'Donations', 'Payment Method',
                   'Code Used', 'Payment Received By', 'Confirmation', 'Bus',
                   'Parent', 'First Name', 'Last Name', 'Full Name', 'Language', 'Email Address', 'Phone Number',
                   'Address', '1st Child - First Name', '1st Child - Last Name', '1st Child - Full Name',
                   '1st Child - Date of Birth', '1st Child - Age', '1st Child - Grade Name', '2nd Child - First Name',
                   '2nd Child - Last Name', '2nd Child - Full Name', '2nd Child - Date of Birth',
                   '2nd Child - Age', '2nd Child - Grade Name', '3rd Child - First Name', '3rd Child - Last Name',
                   '3rd Child - Full Name', '3rd Child - Date of Birth', '3rd Child - Age', '3rd Child - Grade Name',
                   '4th Child - First Name', '4th Child - Last Name', '4th Child - Full Name', '4th Child - Date of Birth',
                   '4th Child - Age', '4th Child - Grade Name', '5th Child - First Name', '5th Child - Last Name',
                   '5th Child - Full Name', '5th Child - Date of Birth', '5th Child - Age', '5th Child - Grade Name',
                   'Number of children'] # customize yourself
    rawcsv = CSV.generate(col_sep: ',') do |csv|
      # here you could add headers
      csv << csv_headers
      # scoped_collection is provided by activeadmin and takes into account the filtering and scoping of the current collection
      parents = Parent.ransack(params[:q]).result.includes(:secondary_parent, :children)
      logger.debug parents
      secondary_parents = parents.map(&:secondary_parent)
      parents.each do |parent|
        csv << parent.csv
      end

      secondary_parents.select(&:present?).each do |parent|
        csv << parent.csv
      end
    end
    send_data(rawcsv, type: 'text/csv charset=utf-8; header=present',
                      filename: "parents-export-#{Time.now.strftime('%Y%m%e-%H%M%S')}.csv") and return
  end
end

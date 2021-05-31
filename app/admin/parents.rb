ActiveAdmin.register Parent do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at,
                :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :password, :password_confirmation,
                :first_name, :last_name, :full_name, :phone_number, :address, :preferred_language, :mailing_list,
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

  index do
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
    end

    panel "Secondary parent" do
      table_for parent.secondary_parent do
        column :id do |p|
          link_to p.id, admin_secondary_parent_path(p)
        end
        column :email
        column :first_name
        column :last_name
        column :full_name
        column :phone_number
        column :address
        column :preferred_language

      end
    end

    panel "Children" do
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

    panel "Bus registration" do
      table_for parent.bus_services do
        column :id do |b|
          link_to b.id, admin_bus_service_path(b)
        end
        column :year
      end
    end
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

      f.inputs "Seconday parent" do
        f.semantic_fields_for :secondary_parent do |sp|
          sp.inputs :email, :first_name, :last_name, :full_name, :address, :phone_number, :preferred_language
        end
      end


      f.has_many :children, allow_destroy: true, heading: "Children" do |p|
        p.inputs :first_name, :last_name, :full_name, :birth_date, :grade
      end

      f.has_many :bus_services, allow_destroy: true, heading: "Bus Services" do |p|
        p.inputs :year
      end
    end
    f.actions
  end
  controller do
    def update
      if params[:parent][:password].blank? && params[:parent][:password_confirmation].blank?
        params[:parent].delete("password")
        params[:parent].delete("password_confirmation")
      end
      super
    end
  end
end

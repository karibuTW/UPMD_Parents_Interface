# frozen_string_literal: true

ActiveAdmin.register Child do
  menu priority: 30
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :full_name, :birth_date, :previous_grade, :grade, :parent_id, :age,
                :public_comment, :taking_bus
  #
  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :full_name, :birth_date, :grade, :parent_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :parent
  filter :first_name
  filter :last_name
  filter :full_name
  filter :birth_date
  filter :grade, as: :select, collection: Child.grades.keys.to_a
  filter :age
  filter :taking_bus
  show do

    attributes_table do
      row :first_name
      row :last_name
      row :full_name
      row :birth_date
      row :age
      row "Grade (#{Setting.current_school_year_start - 1} - #{Setting.current_school_year_start})" do
        child.previous_grade
      end
      row "Grade (#{Setting.current_school_year_start} - #{Setting.current_school_year_end})" do
        child.grade
      end
      row :taking_bus
      row :conditions
      row :public_comment
    end

    panel "Parent" do
      attributes_table_for child.parent do
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
        row :public_comment
      end
    end


    panel "Secondary parent" do
      if child.secondary_parent
        attributes_table_for child.secondary_parent do
          row :id
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
          p "No secondary parent"
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    f.inputs :parent, :first_name, :last_name, :full_name, :grade
    f.input :birth_date, as: :date_picker
    f.input :taking_bus
    f.input :conditions
    f.input :public_comment
    f.actions
  end

  action_item :download_as_csv, only: [:index] do
    a(href: admin_children_path(format: :csv, q: params.to_unsafe_h[:q])) do
      'Download as csv'
    end
  end


  # index download_links: false
  csv do
    column :created_at
    column :updated_at
    column(:bus) { |child| child.parent.has_current_bus_registration? ? 'Y' : 'N' }
    column(:renew?) { |child| child.parent.renewed_bus_service? ? 'Renew' : 'New' }
    column :id
    column :first_name
    column :last_name
    column :full_name
    column :birth_date
    column :age
    column('Unaccompanied?') { |child| child.unaccompanied? ? 'Y':'N' }
    column :grade
    column :taking_bus
    column :conditions
    column('ID') { |child| child.parent.id }
    column('First Name') { |child| child.parent.first_name }
    column('Last Name') { |child| child.parent.last_name }
    column('Full Name') { |child| child.parent.full_name }
    column('Language') { |child| child.parent.preferred_language }
    column('Email') { |child| child.parent.email }
    column('Phone Number') { |child| child.parent.phone_number }
    column('Address') { |child| child.parent.address }

    column('ID') { |child| child.secondary_parent&.id }
    column('First Name') { |child| child.secondary_parent&.first_name }
    column('Last Name') { |child| child.secondary_parent&.last_name }
    column('Full Name') { |child| child.secondary_parent&.full_name }
    column('Language') { |child| child.secondary_parent&.preferred_language }
    column('Email') { |child| child.secondary_parent&.email }
    column('Phone Number') { |child| child.secondary_parent&.phone_number }
    column('Address') { |child| child.secondary_parent&.address }
  end
end

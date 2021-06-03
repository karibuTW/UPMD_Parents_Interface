# frozen_string_literal: true

ActiveAdmin.register Child do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :full_name, :birth_date, :grade, :parent_id, :age
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

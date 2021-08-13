# frozen_string_literal: true

class ParentParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:email, :first_name, :last_name, :full_name, :mailing_list,
                            :address, :preferred_language, :password, :password_confirmation, :phone_number, { nationalities: [] },
                            { children_attributes: [:id, :_destroy, :first_name, :last_name, :full_name, :previous_grade,
                                                    :grade, :birth_date, :taking_bus, :conditions, { nationalities: [] }],
                              secondary_parent_attributes: [:id, :_destroy, :email, :first_name, :last_name, :full_name,
                              :address, :preferred_language, :phone_number, :primary_parent_id, { nationalities: []}],
                              bus_services_attributes: %i[id _destroy] }])
    permit(:account_update, keys: [:email, :first_name, :last_name, :full_name, :mailing_list,
                                   :address, :preferred_language, :password, :password_confirmation, :phone_number, { nationalities: [] },
                                   { children_attributes: [:id, :_destroy, :first_name, :last_name, :full_name, :previous_grade,
                                                           :grade, :birth_date, :taking_bus, :conditions, { nationalities: [] }],
                                     secondary_parent_attributes: [:id, :_destroy, :email, :first_name, :last_name, :full_name,
                                                                   :address, :preferred_language, :phone_number, :primary_parent_id, { nationalities: []}],
                                     bus_services_attributes: %i[id _destroy] }])
  end
end

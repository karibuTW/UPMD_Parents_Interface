class ParentParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:email, :first_name, :last_name, :full_name,
                            :address, :preferred_language, :password, :password_confirmation, :phone_number])
  end
end
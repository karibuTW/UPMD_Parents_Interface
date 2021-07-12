class CustomDeviseMailer < Devise::Mailer
  def devise_mail(*args)
    user = args.first
    I18n.locale = user&.preferred_language || I18n.default_locale
    super
  end
end
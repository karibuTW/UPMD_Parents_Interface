# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :switch_locale
  protected



  def default_url_options
    { locale: I18n.locale }
  end

  def devise_parameter_sanitizer
    if resource_class == Parent
      ParentParameterSanitizer.new(Parent, :parent, params)
    else
      super
    end
  end

  def switch_locale
    if parent_signed_in?
      cookies.permanent[:locale] = current_parent.try(:preferred_language)
    elsif params[:locale].present?
      cookies.permanent[:locale] = params[:locale]
    end

    locale = cookies[:locale]&.to_sym # read cookies

    if I18n.available_locales.include?(locale)
      I18n.locale = locale # use cookies locale
    end
  end
end

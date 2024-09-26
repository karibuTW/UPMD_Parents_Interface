# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :switch_locale

  def create_db_backup
    system("mkdir ../dbbackups")
    @time_stamp = Time.now.strftime("%d_%m_%Y") + "_backup.tar"
    @db_name = 'myupmd'
    @command = "pg_dump -F t #{@db_name} > ../dbbackups/#{@time_stamp}"
    system(@command)
    redirect_to admin_root_path, notice:"DB backup created #{@time_stamp}"
  end

  def download_db_backup
    @time_stamp = Time.now.strftime("%d_%m_%Y") + "_backup.tar"
    send_file("../dbbackups/#{@time_stamp}")
  end


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

  def set_locale_from_parent
    return unless parent_signed_in?

    cookies.permanent[:locale] = current_parent.try(:preferred_language)
  end

  def set_locale_from_param
    return unless params[:locale].present?

    cookies.permanent[:locale] = params[:locale]
  end

  def switch_locale
    set_locale_from_parent
    set_locale_from_param

    redirect_to locale_choose_locale_path(redirect_to: request.fullpath) unless cookies[:locale].present?

    locale = cookies[:locale]&.to_sym # read cookies

    return unless I18n.available_locales.include?(locale)

    I18n.locale = locale # use cookies locale
  end

  def access_denied(exception)
    redirect_to admin_dashboard_path, alert: exception.message
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :bus_driver
      new_bus_driver_session_path
    else
      root_path
    end
  end
end

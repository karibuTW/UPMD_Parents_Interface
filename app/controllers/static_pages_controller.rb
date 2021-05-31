class StaticPagesController < ApplicationController
  before_action :check_locale
  before_action :check_signed_in


  def home
  end

  protected
  def check_signed_in
    if parent_signed_in?
      redirect_to parents_root_path and return
    end

    if bus_driver_signed_in?
      redirect_to bus_drivers_root_path and return
    end
    redirect_to viewers_root_path if viewer_signed_in?
  end

  def check_locale
    redirect_to locale_choose_locale_path unless cookies[:locale].present?
  end
end

# frozen_string_literal: true

# app/admin/setting.rb
ActiveAdmin.register_page 'Setting' do
  menu priority: 80
  content do
    if authorized? :manage, Setting
      form_for Setting.new, url: admin_setting_create_settings_path do |f|
        div class: 'p-5' do
          f.label :current_school_year_start
          f.number_field :current_school_year_start, value: Setting.current_school_year_start
        end

        div class: 'p-5' do
          f.label :helloasso_organization_slug
          f.text_field :helloasso_organization_slug, value: Setting.helloasso_organization_slug
        end

        div class: 'p-5' do
          f.label :helloasso_current_form_id
          f.text_field :helloasso_current_form_id, value: Setting.helloasso_current_form_id
        end

        div do
          f.submit 'Save', class: 'submit' if authorized? :create, Setting
        end
      end
    else
      p "Not authorized"
    end

  end
  page_action :create_settings, method: :post do
    @errors = ActiveModel::Errors.new(Setting)
    setting_params = params.require(:setting).permit(:current_school_year_start, :helloasso_organization_slug,
                                                     :helloasso_current_form_id)
    setting_params.each_key do |key|
      next if setting_params[key].nil?

      setting = Setting.new(var: key)
      setting.value = setting_params[key].strip
      @errors.merge!(setting.errors) unless setting.valid?
    end

    render :new if @errors.any?

    setting_params.each_key do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end

    redirect_to admin_setting_path, notice: 'Setting was successfully updated.'
  end
end

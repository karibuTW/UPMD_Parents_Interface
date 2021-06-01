# app/admin/setting.rb
ActiveAdmin.register_page 'Setting' do
  content do
    form_for Setting.new, url: admin_setting_create_settings_path do |f|

      div class: "p-5" do
        f.label :current_school_year_start
        f.number_field :current_school_year_start, value: Setting.current_school_year_start
      end

      div do
        f.submit "Save", class: "submit"
      end

    end
  end
  page_action :create_settings, method: :post do
      @errors = ActiveModel::Errors.new(Setting)
      setting_params = params.require(:setting).permit(:current_school_year_start)
      setting_params.keys.each do |key|
        next if setting_params[key].nil?

        setting = Setting.new(var: key)
        setting.value = setting_params[key].strip
        unless setting.valid?
          @errors.merge!(setting.errors)
        end
      end

      if @errors.any?
        render :new
      end

      setting_params.keys.each do |key|
        Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
      end

      redirect_to admin_setting_path, notice: "Setting was successfully updated."

  end
end
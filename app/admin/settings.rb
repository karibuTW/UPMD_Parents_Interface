# ActiveAdmin.register Setting do
#
#   index do
#     table :class => 'settings' do
#       thead do
#         th 'Setting'
#         th 'Value'
#         th ''
#       end
#       Setting.keys.each do |key|
#         tr do
#           td strong key
#           td Setting.send(key)
#           td do
#             link_to "delete", admin_settings_delete_path( :key => key ), :method => :post
#           end
#         end
#       end
#       tr do
#         form :action => admin_settings_create_path, :method => :post do
#           td do
#             input :name => 'key'
#           end
#           td do
#             input :name => 'val'
#           end
#           td do
#             input :type => 'submit', :value => 'Add'
#           end
#         end
#       end
#     end
#   end
#
#   controller do
#     def create
#       @errors = ActiveModel::Errors.new
#       setting_params.keys.each do |key|
#         next if setting_params[key].nil?
#
#         setting = Setting.new(var: key)
#         setting.value = setting_params[key].strip
#         unless setting.valid?
#           @errors.merge!(setting.errors)
#         end
#       end
#
#       if @errors.any?
#         render :new
#       end
#
#       setting_params.keys.each do |key|
#         Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
#       end
#
#       redirect_to admin_settings_path, notice: "Setting was successfully updated."
#     end
#
#     private
#     def setting_params
#       params.require(:setting).permit(:host, :user_limits, :admin_emails,
#                                       :captcha_enable, :notification_options)
#     end
#   end
# end
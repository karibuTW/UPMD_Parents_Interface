ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :first_name, :last_name, :role
  config.comments = false
  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :role
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :role

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end

end

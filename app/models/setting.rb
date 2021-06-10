# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  # Define your fields
  # field :host, type: :string, default: "http://localhost:3000"
  field :default_locale, default: "en", type: :string
  field :current_school_year_start, default: Time.now.year, type: :integer
  field :current_school_year_end, default: -> { self.current_school_year_start + 1 }, type: :integer
  field :helloasso_access_token, type: :string
  field :helloasso_refresh_token, type: :string
  field :helloasso_access_token_expires, type: :string
  field :helloasso_organization_slug, default: "union-des-parents-du-lycee-marguerite-duras", type: :string
  field :helloasso_current_form_id, default: "adhesion-2021-2022-2", type: :string
  # field :confirmable_enable, default: "0", type: :boolean
  # field :admin_emails, default: "admin@rubyonrails.org", type: :array
  # field :omniauth_google_client_id, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_ID"] || ""), type: :string, readonly: true
  # field :omniauth_google_client_secret, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_SECRET"] || ""), type: :string, readonly: true
end

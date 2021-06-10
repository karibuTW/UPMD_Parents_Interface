# frozen_string_literal: true

module Helloasso
  class Token
    include HTTParty
    base_uri 'https://api.helloasso.com'
    logger ::Logger.new $stdout
    def self.get_access_token
      result = post('/oauth2/token', {
                      body: {
                        client_id: Rails.application.credentials.dig(:helloasso, :client_id),
                        client_secret: Rails.application.credentials.dig(:helloasso, :client_secret),
                        grant_type: 'client_credentials'
                      }
                    })
      data = JSON.parse(result.body)
      Setting.helloasso_access_token = data['access_token']
      Setting.helloasso_refresh_token = data['refresh_token']
      Setting.helloasso_access_token_expires = Time.zone.now + data['expires_in'].to_i
    end

    def self.refresh_access_token
      if Setting.helloasso_refresh_token.nil?
        get_access_token and return
      end

      result = post('/oauth2/token', {
                      body: {
                        client_id: Rails.application.credentials.dig(:helloasso, :client_id),
                        refresh_token: Setting.helloasso_refresh_token,
                        grant_type: 'refresh_token'
                      }
                    })
      data = JSON.parse(result.body)
      Setting.helloasso_access_token = data['access_token']
      Setting.helloasso_refresh_token = data['refresh_token']
      Setting.helloasso_access_token_expires = Time.zone.now + data['expires_in'].to_i
    end

    def self.access_token
      is_refresh_needed? && refresh_access_token
      Setting.helloasso_access_token
    end

    def self.is_refresh_needed?
      Time.now > Setting.helloasso_access_token_expires
    end
  end
end

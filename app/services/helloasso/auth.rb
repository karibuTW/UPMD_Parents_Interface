# frozen_string_literal: true

module Helloasso
  module Auth
    class AuthClass
      include HTTParty

      def initialize(access_token)
        self.class.headers({ 'Authorization' => "Bearer #{access_token}" })
      end

      private

      def respond_to_missing?(method, *)
        %i[get put post patch destroy].include? method
      end

      def method_missing(symbol, *args, &block)
        response = self.class.send(symbol, *args, &block)
        case response.code
        when 200
          response
        when 401
          Token.refresh_access_token
          response = self.class.send(symbol, *args, &block)
          if response.code == 200
            response
          else
            p response
            raise ArgumentError.new 'Unauthenticated'
          end
        else
          p response
          raise ArgumentError.new 'An error occurred'
        end
      end
    end

    def self.authenticate
      access_token = Token.access_token
      auth = AuthClass.new(access_token)
      yield auth if block_given?
    end
  end
end

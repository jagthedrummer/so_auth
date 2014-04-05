require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class So < OmniAuth::Strategies::OAuth2

      CUSTOM_PROVIDER_URL = ENV['AUTH_PROVIDER_URL'] || "http://custom-provider-goes-here"
      CUSTOM_PROVIDER_ME_URL = ENV['AUTH_PROVIDER_ME_URL'] || "/oauth/me.json"

      option :client_options, {
        :site =>  CUSTOM_PROVIDER_URL,
        :authorize_url => "#{CUSTOM_PROVIDER_URL}/oauth/authorize",
        :access_token_url => "#{CUSTOM_PROVIDER_URL}/oauth/token"
      }

      uid {
        raw_info['id'] 
      }

      info do
        {
          :email => raw_info['email'],
          :admin => raw_info['admin']
        }
      end

      extra do
        {
          #:current_sign_in_at => raw_info['extra']['current_sign_in_at'],
          #:name => raw_info['extra']['name']
          #:first_name => raw_info['extra']['first_name'],
          #:last_name  => raw_info['extra']['last_name']
        }
      end

      def raw_info
        @raw_info ||= access_token.get(CUSTOM_PROVIDER_ME_URL).parsed
      end
    end
  end
end


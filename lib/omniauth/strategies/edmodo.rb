require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Edmodo < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.edmodo.com',
        :authorize_url => 'https://api.edmodo.com/oauth/authorize',
        :token_url => 'https://api.edmodo.com/oauth/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['username'],
          'email' => raw_info['email'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
          'image' => raw_info.fetch('avatars', {})['large']
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('users/me').parsed
      end

      private

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end

OmniAuth.config.add_camelization 'edmodo', 'Edmodo'

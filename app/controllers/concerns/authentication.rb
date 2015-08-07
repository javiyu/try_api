module Concerns
  module Authentication
    extend ActiveSupport::Concern

    included do
      attr_accessor :current_user

      def authenticate
        if user = authenticate_with_http_basic{|name, password| User.find_by(name: name, password: password) }
          @current_user = user
        else
          head :unauthorized
        end
      end

    end

  end
end

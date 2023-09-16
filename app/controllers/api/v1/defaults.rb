module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json

        helpers do
          def authenticate!
            error!('Please log in', :unauthorized) unless logged_in?
          end

          def logged_in?
            !!current_user
          end

          def current_user
            if decoded_token
              admin_id = decoded_token[0]['admin_id']
              @admin = Admin.find_by(id: admin_id)
            end
          end

          def decoded_token
            if auth_header
              token = auth_header
              begin
                JWT.decode(token, 'cd817ce2dab72589691e2b889a87bd0a', true,
                           algorithm: 'HS256')
              rescue JWT::DecodeError
                nil
              end
            end
          end

          def auth_header
            request.headers['Authorization']
          end

          def encode_token(payload)
            JWT.encode(payload, 'cd817ce2dab72589691e2b889a87bd0a')
          end
        end

      end
    end
  end
end
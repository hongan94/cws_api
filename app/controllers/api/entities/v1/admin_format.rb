module API
  module Entities
    module V1
      class AdminFormat < Grape::Entity
        expose :id
        expose :fullname
        expose :gender
        expose :phone
        expose :email
        expose :address
        expose :role
        expose :status
      end
    end
  end
end

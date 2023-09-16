module Entities::V1
  class AdminFormat < Grape::Entity
    expose :id
    expose :fullname
    expose :gender
    expose :phone
    expose :email
    expose :address
  end
end
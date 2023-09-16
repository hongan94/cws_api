module Api
  module V1
    class Base < Grape::API
      mount Api::V1::Admins
    end
  end
end
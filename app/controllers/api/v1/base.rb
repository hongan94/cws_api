module API
  module V1
    class Base < Grape::API
      mount V1::Admins
    end
  end
end
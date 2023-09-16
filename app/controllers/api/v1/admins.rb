module Api
  module V1
    class Admins < Grape::API
      version 'v1', using: :path

      resource :admins do
        desc 'Get list admins'
        get do
          @admins = Admin.all
          present @admins, with: Entities::V1::AdminFormat
        end

        desc 'Create admin'
        params do
          requires :name, type: String
          requires :quantity, type: Integer
          requires :price, type: Integer
        end
        post do
          @product = Admin.create!(params)
          present @product, with: Entities::V1::AdminFormat
        end

        route_param :id do
          before do
            @product = Admin.find(params[:id])
          end

          desc 'Show a admin'
          get do
            @product
            present @product, with: Entities::V1::ProductFormat
          end

          desc 'Update a admin'
          params do
            requires :id, type: Integer
            requires :name, type: String
            requires :quantity, type: Integer
            requires :price, type: Integer
          end
          patch do
            @product.update(params)
            present @product, with: Entities::V1::ProductFormat
          end

          desc 'Delete a admin'
          params do
            requires :id, type: String
          end
          delete do
            @product.destroy
          end
        end
      end
    end
  end
end
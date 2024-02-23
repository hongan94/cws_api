module API
  module V1
    class Admins < Grape::API
      include API::V1::Defaults

      before do
        unless env['api.endpoint'].options[:path].join('/') == 'login'
          authenticate!
        end
      end

      resource :admins do
        desc 'Get list admins'
        get do
          @admins = Admin.all
          { status: 'success', message: 'Thành công', data: API::Entities::V1::AdminFormat.represent(@admins) }
        end

        desc 'Create admin'
        # params do
        #   requires :fullname, type: String
        #   requires :password, type: String
        #   requires :phone, type: String
        #   requires :email, type: String
        #   requires :address, type: String
        #   requires :gender, type: String
        #   requires :status, type: String
        #   requires :role, type: String
        # end
        post do
          @admin = Admin.new(params)
          if @admin.save
            { status: 'success', message: 'Thành công', data: API::Entities::V1::AdminFormat.represent(@admins) }
          else
             { status: 'error', message: @admin.errors.full_messages, data: {} }
          end
        end

        route_param :id do
          before do
            @admin = Admin.find(params[:id])
          end

          desc 'Show a admin'
          get do
            @admin
            present @admin, with: Entities::V1::ProductFormat
          end

          desc 'Update a admin'
          params do
            requires :id, type: Integer
            requires :name, type: String
            requires :quantity, type: Integer
            requires :price, type: Integer
          end
          patch do
            @admin.update(params)
            present @admin, with: Entities::V1::ProductFormat
          end

          desc 'Delete a admin'
          params do
            requires :id, type: String
          end
          delete do
            @admin.destroy
          end
        end

        desc 'login'
        params do
          requires :password, type: String
          optional :email, type: String, desc: 'User email address'
          optional :phone, type: String, desc: 'User phone number'
        end
        post 'login' do
          @admin = Admin.where("email = ? OR phone = ?", params[:email], params[:phone]).first
          if @admin && @admin.authenticate(params[:password])
            present jwt_token: encode_token({admin_id: @admin.id})
          else
            error!('Mật khẩu hoặc tài khoản không đúng', 401)
          end
        end
      end
    end
  end
end
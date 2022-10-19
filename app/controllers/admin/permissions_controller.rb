# frozen_string_literal: true

module Admin
  class PermissionsController < AdminController
    before_action :set_permission, only: %i[show destroy]

    def index
      permissions = PermissionService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @permissions = permissions.success
      serialize!(Permission, @permissions, paginate(@permissions))
    end

    def create
      permission = PermissionService::Create.new(params: permission_params).call

      permission.instance_of?(Permission) ? serialize!(Permission, permission) : error!(permission.failure[1])
    end

    def show
      @permission ? serialize!(Permission, @permission) : error!(I18n.t('c.errors.data_not_found'))
    end

    def update
      permission = PermissionService::Update.new(params: permission_params, record: @permission).call

      permission.instance_of?(Permission) ? serialize!(Permission, permission) : error!(permission.failure[1])
    end

    def destroy
      permission = PermissionService::Destroy.new(record: @permission).call

      permission.instance_of?(Permission) ? destroyed! : error!(permission.failure[1])
    end

    private

    def permission_params
      params.require(:permission).permit(:object_type, :action_name, :description)
    end

    def set_permission
      @permission = Permission.find_by(id: params[:id])
    end
  end
end

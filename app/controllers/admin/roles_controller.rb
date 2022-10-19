# frozen_string_literal: true

module Admin
  class RolesController < AdminController
    before_action :set_role, only: %i[show]

    def index
      roles = RoleService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @roles = roles.success
      serialize!(Role, @roles, paginate(@roles))
    end

    def create
      role = RoleService::Create.new(params: role_params).call

      role.instance_of?(Role) ? serialize!(Role, role) : error!(role.failure[1])
    end

    def show
      @role ? serialize!(Role, @role) : error!(I18n.t('c.errors.data_not_found'))
    end

    private

    def role_params
      params.require(:role).permit(:name, :resource_id, :resource_type)
    end

    def set_role
      @role = Role.find_by(id: params[:id])
    end
  end
end

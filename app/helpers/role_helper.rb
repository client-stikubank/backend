# frozen_string_literal: true

module RoleHelper
  def authenticate_admin!
    return if current_user&.admin?

    render json: { errors: I18n.t('helpers.role.admin_only') }, status: :unauthorized
  end
end
# frozen_string_literal: true

module RoleHelper
  def authenticate_user!
    return if current_user

    render json: { errors: I18n.t('helpers.role.unauthorized') }, status: :unauthorized
  end

  def authenticate_admin!
    return if current_user&.admin_user?

    render json: { errors: I18n.t('helpers.role.admin_only') }, status: :unauthorized
  end

  def authenticate_mobile!
    return if current_user&.mobile_user?

    render json: { errors: I18n.t('helpers.role.mobile_user_only') }, status: :unauthorized
  end
end

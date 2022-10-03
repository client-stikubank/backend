# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_client, only: %i[create]

  include DoorkeeperRegisterable

  def create
    @form = UserForm::Registration.new(User.new)

    unless @form.validate(registration_params)
      return render json: to_json_form_errors(@form),
                    status: :unauthorized
    end

    @form.save do |form_params|
      service = RegistrationService::Register.new(params: form_params.deep_symbolize_keys).call

      return render json: render_user(service, @client_app), status: :created if service.instance_of?(User)

      render json: { errors: service.failure[1] }, status: :unprocessable_entity
    end
  end

  private

  def check_client
    @client_app = Doorkeeper::Application.find_by(uid: registration_params[:client_id])

    return if @client_app

    render json: { errors: { client: [I18n.t('doorkeeper.errors.messages.invalid_client')] } },
           status: :bad_request
  end

  def registration_params
    params.permit(:client_id, :email, :password, :password_confirmation, :reffering_code, user_profile: [:first_name, :last_name, :phone_number, :birth_date],
      parent_information: [:graduate_status, :occupation, :salary_level],
      student_information: [:education_status, :previous_school],
      role_types: [])
  end
end

# frozen_string_literal: true

module Admin
  class LoginController < ApplicationController
    before_action :check_client, only: %i[create]

    include DoorkeeperRegisterable

    def create
      @form = UserForm::Registration.new(User.new)

      unless @form.validate(login_params.except(:client_id, :client_secret))
        return render json: to_json_form_errors(@form),
                      status: :unauthorized
      end

      @form.save do |_form_params|
        user = User.kept.authenticate(params[:email], params[:password])

        unless user
          return render json: { errors: I18n.t('controllers.admin.login.errors.invalid_credentials') },
                        status: :unprocessable_entity
        end

        unless user.admin_user?
          return render json: { errors: I18n.t('helpers.role.admin_only') },
                        status: :unprocessable_entity
        end

        render json: render_user(user, @client_app)
      end
    end

    private

    def check_client
      @client_app = Doorkeeper::Application.find_by(
        uid: login_params[:client_id],
        secret: login_params[:client_secret]
      )

      return if @client_app

      render json: { errors: { client: [I18n.t('doorkeeper.errors.messages.invalid_client')] } },
             status: :bad_request
    end

    def login_params
      params.permit(:email, :password, :client_id, :client_secret)
    end
  end
end

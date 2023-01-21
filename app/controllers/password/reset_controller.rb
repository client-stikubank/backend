module Password
  class ResetController < ApplicationController
    before_action :set_user

    def create
      return render json: { errors: "User #{I18n.t('errors.messages.not_found')}" }, status: :unprocessable_entity if @user.blank?

      SendResetPasswordWorker.perform_async(@user.id)
      render json: { message: I18n.t('devise.passwords.send_instructions') }, status: :ok
    end

    def update
      return render json: { message: 'Reset Code salah' }, status: :unprocessable_entity unless @user.reset_code == params[:reset_code]

      if @user.update(password_params)
        render json: { message: I18n.t('devise.passwords.updated_not_active') }, status: :ok
      else
        render json: { message: 'error' }, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find_by(email: params[:email])
    end

    def password_params
      params.permit(:email, :reset_code, :password, :password_confirmation)
    end
  end
end

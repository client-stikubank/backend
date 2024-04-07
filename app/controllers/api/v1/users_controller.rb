# frozen_string_literal: true
module Api
  module V1
    class UsersController < MobileController
      before_action :set_user, only: %i[update_password delete_account]

      def update_password
        user = UserService::Update.new(params: user_params, record: @user).call

        user.instance_of?(User) ? serialize!(User, user) : error!(user.failure[1])
      end

      def delete_account
        render json: { success: @user.discard }
      end

      private

      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end

      def set_user
        @user = User.find_by(id: current_user.id)
      end
    end
  end
end

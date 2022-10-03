# frozen_string_literal: true
module Api
  module V1
    class UsersController < MobileController
      before_action :set_user, only: %i[update_password]

      def update_password
        user = UserService::Update.new(params: user_params, record: @user).call

        user.instance_of?(User) ? serialize!(User, user) : error!(user.failure[1])
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

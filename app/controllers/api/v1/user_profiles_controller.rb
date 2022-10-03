# frozen_string_literal: true

module Api
  module V1
    class UserProfilesController < MobileController
      before_action :set_user_profile, only: %i[display_profile update_profile]

      def update_profile
        user_profile = UserProfileService::Update.new(params: user_profile_params, record: @user_profile).call

        user_profile.instance_of?(UserProfile) ? serialize!(User, user_profile.user) : error!(user_profile.failure[1])
      end

      def display_profile
        user = @user_profile.user
        @user_profile ? serialize!('User', user) : error!(I18n.t('controllers.errors.data_not_found'))
      end

      private

      def user_profile_params
        params.require(:user_profile).permit(:first_name, :last_name, :phone_number, :birth_date, :city_id,
        parent_information_attributes: [:id, :graduate_status, :occupation, :salary_level],
        student_information_attributes: [:id, :education_status, :previous_school])
      end

      def set_user_profile
        @user_profile = UserProfile.find_by(id: current_user.user_profile.id)
      end
    end
  end
end

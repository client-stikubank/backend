# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[show update destroy]
    before_action :set_own_user, only: %i[update_password]

    def index
      users = UserService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @users = users.success
      serialize!(User, @users, paginate(@users))
    end

    def create
      user = UserService::Create.new(params: user_params).call

      user.instance_of?(User) ? serialize!(User, user) : error!(user.failure[1])
    end

    def update
      unless params.dig(:user, :user_profile_attributes, :image)
        @user.user_profile.image.cache!
      end
      user = UserService::Update.new(params: edit_user_params, record: @user).call

      user.instance_of?(User) ? serialize!(User, user) : error!(user.failure[1])
    end

    def show
      @user ? serialize!(User, @user) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      user = UserService::Destroy.new(record: @user).call

      user.instance_of?(User) ? destroyed! : error!(user.failure[1])
    end

    def update_password
      user = UserService::Update.new(params: change_password_params, record: @user).call

      user.instance_of?(User) ? serialize!(User, user) : error!(user.failure[1])
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :reffering_code,
        user_profile_attributes: [:first_name, :last_name, :phone_number, :birth_date, :city_id, :image,
        parent_information_attributes: [:graduate_status, :occupation, :salary_level],
        student_information_attributes: [:education_status, :previous_school]],
        role_types: [])
    end

    def edit_user_params
      params.require(:user).permit(:email,
        user_profile_attributes: [:id, :first_name, :last_name, :phone_number, :birth_date, :city_id, :image,
        parent_information_attributes: [:id, :graduate_status, :occupation, :salary_level],
        student_information_attributes: [:id, :education_status, :previous_school]],
        role_types: [])
    end

    def change_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def set_own_user
      @user = User.find_by(id: current_user.id)
    end
  end
end

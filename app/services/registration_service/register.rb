# frozen_string_literal: true

require 'dry/monads/do'

class RegistrationService::Register
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params

  def initialize(params:)
    profile_params             = params[:user_profile]
    parent_information_params  = params[:parent_information]
    student_information_params = params[:student_information]
    user_params                = params.except(:user_profile, :parent_information, :student_information)

    user_params[:user_profile_attributes]                                  = profile_params
    user_params[:user_profile_attributes][:parent_information_attributes]  = parent_information_params if parent_information_params.present?
    user_params[:user_profile_attributes][:student_information_attributes] = student_information_params if student_information_params.present?

    @params  = user_params
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      yield call_create_user
    end
  end

  private

  def call_create_user
    user_respond = UserService::Create.new(params: @params).call

    if user_respond.instance_of?(User)
      Success(user_respond)
    else

      user_respond
    end
  end
end

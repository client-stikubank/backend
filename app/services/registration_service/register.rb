# frozen_string_literal: true

require 'dry/monads/do'

class RegistrationService::Register
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params

  def initialize(params:)
    profile_params                        = params[:user_profile]
    user_params                           = params.except(:user_profile)
    user_params[:user_profile_attributes] = profile_params
    @params                               = user_params
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

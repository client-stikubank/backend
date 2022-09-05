# frozen_string_literal: true

require 'dry/monads/do'

class UserService::Create
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      yield call_create_record
    end
  end

  private

  def call_create_record
    user          = User.new(params)
    user.password = Devise.friendly_token.first(8) if user.password.blank?

    if user.save
      Success(user)
    else
      Failure([:error, user.errors])
    end
  end
end

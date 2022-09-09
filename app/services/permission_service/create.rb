# frozen_string_literal: true

require 'dry/monads/do'

class PermissionService::Create
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
    permission = Permission.new(params)

    if permission.save
      Success(permission)
    else
      Failure([:error, permission.errors])
    end
  end
end

# frozen_string_literal: true

require 'dry/monads/do'

class RoleService::Create
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
    role = Role.new(params)

    if role.save
      Success(role)
    else
      Failure([:error, role.errors])
    end
  end
end

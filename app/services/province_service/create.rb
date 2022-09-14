# frozen_string_literal: true

require 'dry/monads/do'

class ProvinceService::Create
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
    province = Province.new(params)

    if province.save
      Success(province)
    else
      Failure([:error, province.errors])
    end
  end
end

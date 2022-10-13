# frozen_string_literal: true

require 'dry/monads/do'

class CarnivalGiftService::Create
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
    carnival_gift = CarnivalGift.new(params)

    if carnival_gift.save
      Success(carnival_gift)
    else
      Failure([:error, carnival_gift.errors])
    end
  end
end

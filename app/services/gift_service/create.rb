# frozen_string_literal: true

require 'dry/monads/do'

class GiftService::Create
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
    gift = Gift.new(params)

    if gift.save
      Success(gift)
    else
      Failure([:error, gift.errors])
    end
  end
end

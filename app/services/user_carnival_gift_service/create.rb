# frozen_string_literal: true

require "dry/monads/do"

class UserCarnivalGiftService::Create
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params, :user

  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      yield call_create_record
    end
  end

  private

  def call_create_record
    record = user ? user.user_carnival_gifts.new(carnival_gift_id: params[:carnival_gift_id]) : UserCarnivalGift.new(params)

    if record.save
      Success(record)
    else
      Failure([:error, record.errors])
    end
  end
end

# frozen_string_literal: true

require 'dry/monads/do'

class StageCampScheduleService::List
  include ApplicationHelper
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(query: nil, order: nil)
    records = StageCampSchedule.order(order ? order_query(StageCampSchedule, order) : 'created_at DESC')
    Success(records.ransack(query.query).result)
  end
end

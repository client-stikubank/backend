# frozen_string_literal: true

require 'dry/monads/do'

class StageCampService::List
  include ApplicationHelper
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(query: nil, order: nil)
    records = StageCamp.order(order ? order_query(StageCamp, order) : 'created_at DESC')
    Success(records.ransack(query.query).result)
  end
end

# frozen_string_literal: true

require 'dry/monads/do'

class UserCarnivalGiftService::List
  include ApplicationHelper
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(pagination: nil, query: nil, order: nil, record: UserCarnivalGift.all)
    records = record.order(
      order ? order_query(record, order) : 'created_at DESC'
    )
    Success(records.ransack(query.query).result.page(pagination.page).per(pagination.per_page))
  end
end

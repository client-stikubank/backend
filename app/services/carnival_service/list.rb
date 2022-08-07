# frozen_string_literal: true

require "dry/monads/do"

class CarnivalService::List
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(pagination: nil, query: nil)
    records = Carnival.all
    Success(records.ransack(query.query).result.page(pagination.page).per(pagination.per_page))
  end
end

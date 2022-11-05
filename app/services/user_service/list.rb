# frozen_string_literal: true

require 'dry/monads/do'

class UserService::List
  include ApplicationHelper
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(pagination: nil, query: nil, order: nil)
    records = User.includes(:user_profile, :roles).order(order ? order_query(User, order) : 'created_at DESC')
    Success(records.ransack(query.query).result.page(pagination.page).per(pagination.per_page))
  end
end

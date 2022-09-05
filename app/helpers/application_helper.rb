# frozen_string_literal: true

module ApplicationHelper
  def paginate(scope, default_per_page = 20)
    collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

    current = collection.current_page
    total = collection.total_pages
    per_page = collection.limit_value

    {
      current:,
      previous: (current > 1 ? (current - 1) : nil),
      next: (current == total ? nil : (current + 1)),
      per_page:,
      pages: total,
      count: collection.total_count
    }
  end

  def order_query(klass, order)
    order = order.split
    column_type = klass.column_for_attribute(order[0]).type

    case column_type
    when :string, :text
      order[0] = "LOWER(#{order[0]})"
    end

    order.join(' ')
  end
end

# frozen_string_literal: true

module Api
  module V1
    class EventsController < MobileController
      def index
        events = EventService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: Event.active.where('events.end_date >= ?', Time.zone.now).where('events.start_date <= ?', Time.zone.now)
        )

        @events = events.success
        serialize!(Event, @events, paginate(@events))
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  class EventsController < AdminController
    before_action :set_event, only: %i[show update destroy]

    def index
      events = EventService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @events = events.success
      serialize!(Event, @events, paginate(@events))
    end

    def create
      event = EventService::Create.new(params: event_params).call

      event.instance_of?(Event) ? serialize!(Event, event) : error!(event.failure[1])
    end

    def update
      event = EventService::Update.new(params: event_params, record: @event).call

      event.instance_of?(Event) ? serialize!(Event, event) : error!(event.failure[1])
    end

    def show
      @event ? serialize!(Event, @event) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      event = EventService::Destroy.new(record: @event).call

      event.instance_of?(Event) ? destroyed! : error!(event.failure[1])
    end

    private

    def event_params
      params.require(:event).permit(:name, :image, :status, :city_id, :address, :map_link, :start_date, :end_date, :description, :duration, :event_at, reward_amount: [])
    end

    def set_event
      @event = Event.find_by(id: params[:id])
    end
  end
end

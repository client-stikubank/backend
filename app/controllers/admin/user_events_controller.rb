# frozen_string_literal: true

module Admin
  class UserEventsController < AdminController
    before_action :set_user_event, only: %i[show]

    def index
      user_events = UserEventService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @user_events = user_events.success
      serialize!(UserEvent, @user_events, paginate(@user_events))
    end

    def show
      @user_event ? serialize!(UserEvent, @user_event) : error!(I18n.t('c.errors.data_not_found'))
    end

    private

    def user_event_params
      params.require(:user_event).permit(:user_id, :event_id, :status)
    end

    def set_user_event
      @user_event = UserEvent.find_by(id: params[:id])
    end
  end
end

module Api
  module V1
    class UserEventsController < MobileController
      before_action :set_user_event, only: :update

      def index
        user_events = UserEventService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: current_user.user_events
        )

        @user_events = user_events.success
        serialize!('UserEvent', @user_events, paginate(@user_events))
      end

      def create
        user_event = UserEventService::Create.new(
          params: user_event_params,
          user: current_user
        ).call
        user_event ? serialize!(UserEvent, user_event) : error!(user_event.failure[1])
      end

      def update
        user_event = UserEventService::Update.new(params: user_event_params, record: @user_event).call

        user_event.instance_of?(UserEvent) ? serialize!(UserEvent, @user_event) : error!(user_event.failure[1])
      end

      private

      def user_event_params
        params.require(:user_event).permit(:event_id, :status)
      end

      def set_user_event
        @user_event = UserEvent.find(params[:id])
      end
    end
  end
end

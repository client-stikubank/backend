module Api
  module V1
    class UserCarnivalGiftsController < MobileController
      def index
        user_carnival_gifts = UserCarnivalGiftService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @user_carnival_gifts = current_user.user_carnival_gifts.order('created_at DESC')
        serialize!('UserCarnivalGift', @user_carnival_gifts, paginate(@user_carnival_gifts))
      end

      def create
        user_carnival_gift = UserCarnivalGiftService::Create.new(
          params: user_carnival_gift_params,
          user: current_user
        ).call
        user_carnival_gift ? serialize!(UserCarnivalGift, user_carnival_gift) : error!(user_carnival_gift.failure[1])
      end

      private

      def user_carnival_gift_params
        params.require(:user_carnival_gift).permit(:carnival_gift_id, :status)
      end
    end
  end
end

module Api
  module V1
    class UserCarnivalGiftsController < MobileController
      before_action :set_user_carnival_gift, only: :update

      def index
        user_carnival_gifts = UserCarnivalGiftService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object,
          record: current_user.user_carnival_gifts
        )

        @user_carnival_gifts = user_carnival_gifts.success
        serialize!('UserCarnivalGift', @user_carnival_gifts, paginate(@user_carnival_gifts))
      end

      def create
        user_carnival_gift = UserCarnivalGiftService::Create.new(
          params: user_carnival_gift_params,
          user: current_user
        ).call
        user_carnival_gift ? serialize!(UserCarnivalGift, user_carnival_gift) : error!(user_carnival_gift.failure[1])
      end

      def update
        user_carnival_gift = UserCarnivalGiftService::Update.new(params: user_carnival_gift_params, record: @user_carnival_gift).call

        user_carnival_gift.instance_of?(UserCarnivalGift) ? serialize!(UserCarnivalGift, @user_carnival_gift) : error!(user_carnival_gift.failure[1])
      end

      private

      def user_carnival_gift_params
        params.require(:user_carnival_gift).permit(:carnival_gift_id, :status)
      end

      def set_user_carnival_gift
        @user_carnival_gift = UserCarnivalGift.find(params[:user_carnival_gift_id])
      end
    end
  end
end

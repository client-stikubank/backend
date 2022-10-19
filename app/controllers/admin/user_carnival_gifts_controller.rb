# frozen_string_literal: true

module Admin
  class UserCarnivalGiftsController < AdminController
    before_action :set_user_carnival_gift, only: %i[show]

    def index
      user_carnival_gifts = UserCarnivalGiftService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @user_carnival_gifts = user_carnival_gifts.success
      serialize!(UserCarnivalGift, @user_carnival_gifts, paginate(@user_carnival_gifts))
    end

    def show
      @user_carnival_gift ? serialize!(UserCarnivalGift, @user_carnival_gift) : error!(I18n.t('c.errors.data_not_found'))
    end

    private

    def user_carnival_gift_params
      params.require(:user_carnival_gift).permit(:user_id, :carnival_gift_id, :status)
    end

    def set_user_carnival_gift
      @user_carnival_gift = UserCarnivalGift.find_by(id: params[:id])
    end
  end
end

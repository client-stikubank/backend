module Api
  module V1
    class CarnivalGiftsController < MobileController
      before_action :set_carnival_gift, only: :show

      def index
        carnival_gifts = CarnivalGiftService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @carnival_gifts = carnival_gifts.success
        serialize!(CarnivalGift, @carnival_gifts, paginate(@carnival_gifts))
      end

      def show
        @carnival_gift ? serialize!('CarnivalGift', @carnival_gift) : error!(I18n.t('controllers.errors.data_not_found'))
      end

      private

      def set_carnival_gift
        @carnival_gift = CarnivalGift.find(params[:id])
      end
    end
  end
end

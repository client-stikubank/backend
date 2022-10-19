# frozen_string_literal: true

module Admin
  class CarnivalGiftsController < AdminController
    before_action :set_carnival_gift, only: %i[show update destroy]

    def index
      carnival_gifts = CarnivalGiftService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @carnival_gifts = carnival_gifts.success
      serialize!(CarnivalGift, @carnival_gifts, paginate(@carnival_gifts))
    end

    def create
      carnival_gift = CarnivalGiftService::Create.new(params: carnival_gift_params).call

      carnival_gift.instance_of?(CarnivalGift) ? serialize!(CarnivalGift, carnival_gift) : error!(carnival_gift.failure[1])
    end

    def update
      carnival_gift = CarnivalGiftService::Update.new(params: carnival_gift_params, record: @carnival_gift).call

      carnival_gift.instance_of?(CarnivalGift) ? serialize!(CarnivalGift, carnival_gift) : error!(carnival_gift.failure[1])
    end

    def show
      @carnival_gift ? serialize!(CarnivalGift, @carnival_gift) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      carnival_gift = CarnivalGiftService::Destroy.new(record: @carnival_gift).call

      carnival_gift.instance_of?(CarnivalGift) ? destroyed! : error!(carnival_gift.failure[1])
    end

    private

    def carnival_gift_params
      params.require(:carnival_gift).permit(:carnival_id, :gift_id, :quantity, :status)
    end

    def set_carnival_gift
      @carnival_gift = CarnivalGift.find_by(id: params[:id])
    end
  end
end

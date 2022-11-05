# frozen_string_literal: true

module Admin
  class GiftsController < AdminController
    before_action :set_gift, only: %i[show update destroy]

    def index
      gifts = GiftService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @gifts = gifts.success
      serialize!(Gift, @gifts, paginate(@gifts))
    end

    def create
      gift = GiftService::Create.new(params: gift_params).call

      gift.instance_of?(Gift) ? serialize!(Gift, gift) : error!(gift.failure[1])
    end

    def update
      gift = GiftService::Update.new(params: gift_params, record: @gift).call

      gift.instance_of?(Gift) ? serialize!(Gift, gift) : error!(gift.failure[1])
    end

    def show
      @gift ? serialize!(Gift, @gift) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      gift = GiftService::Destroy.new(record: @gift).call

      gift.instance_of?(Gift) ? destroyed! : error!(gift.failure[1])
    end

    private

    def gift_params
      params.require(:gift).permit(:name, :image, :description, reward_amount: [])
    end

    def set_gift
      @gift = Gift.find_by(id: params[:id])
    end
  end
end

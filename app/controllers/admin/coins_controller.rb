# frozen_string_literal: true

module Admin
  class CoinsController < AdminController
    before_action :set_coin, only: %i[show update]

    def index
      coins = CoinService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @coins = coins.success
      serialize!(Coin, @coins, paginate(@coins))
    end

    def show
      @coin ? serialize!('CoinDetail', @coin) : error!(I18n.t('controllers.errors.data_not_found'))
    end

    def update
      coin = CoinService::Update.new(params: coin_params, record: @coin).call
      coin ? serialize!(Coin, coin) : error!(coin.failure[1])
    end

    private

    def coin_params
      params.require(:coin).permit(:image, :description, :max_supply)
    end

    def set_coin
      @coin = Coin.find_by(id: params[:id])
    end
  end
end

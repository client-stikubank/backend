# frozen_string_literal: true

module Admin
  class StocksController < AdminController
    before_action :set_stock, only: %i[show transactions]

    def index
      stocks = StockService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @stocks = stocks.success
      serialize!(Stock, @stocks, paginate(@stocks))
    end

    def show
      @stock ? serialize!('StockDetail', @stock) : error!(I18n.t('c.errors.data_not_found'))
    end

    def transactions
      @stock ? serialize!(Transaction, @stock.transactions) : error!(I18n.t('c.errors.data_not_found'))
    end

    private

    def set_stock
      @stock = Stock.find_by(id: params[:id])
    end
  end
end
# frozen_string_literal: true

module Admin
  class CarnivalsController < AdminController
    before_action :set_carnival, only: %i[show update activate]

    def index
      carnivals = CarnivalService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @carnivals = carnivals.success
      serialize!(Carnival, @carnivals, paginate(@carnivals))
    end

    def create
      carnival = CarnivalService::Create.new(params: carnival_params).call
      carnival ? serialize!(Carnival, carnival) : error!(carnival.failure[1])
    end

    def show
      @carnival ? serialize!('Admin::CarnivalDetail', @carnival) : error!(I18n.t('c.errors.data_not_found'))
    end

    def update
      carnival = CarnivalService::Update.new(params: carnival_params, record: @carnival).call
      carnival ? serialize!(Carnival, carnival) : error!(carnival.failure[1])
    end

    def activate
      @carnival.activate!

      @carnival ? serialize!('Admin::CarnivalDetail', @carnival) : error!(I18n.t('c.errors.data_not_found'))
    end

    private

    def carnival_params
      params.require(:carnival).permit(:name, :finished_at, :description)
    end

    def set_carnival
      @carnival = Carnival.find_by(id: params[:id])
    end
  end
end

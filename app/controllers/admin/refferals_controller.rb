# frozen_string_literal: true

module Admin
  class RefferalsController < AdminController
    before_action :set_refferal, only: %i[show]

    def index
      refferal = RefferalService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @refferal = refferal.success
      serialize!(Refferal, @refferal, paginate(@refferal))
    end


    def show
      @refferal ? serialize!(Refferal, @refferal) : error!(I18n.t('controllers.errors.data_not_found'))
    end

    private

    def set_refferal
      @refferal = Refferal.find_by(id: params[:id])
    end
  end
end

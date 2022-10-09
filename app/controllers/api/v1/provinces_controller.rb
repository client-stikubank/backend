# frozen_string_literal: true

module Api
  module V1
    class ProvincesController < MobileController
      skip_before_action :doorkeeper_authorize!, raise: false
      skip_before_action :authenticate_mobile!, raise: false

      def index
        provinces = ProvinceService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @provinces = provinces.success
        serialize!(Province, @provinces, paginate(@provinces))
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    class CitiesController < MobileController
      def index
        cities = CityService::List.new.call(
          query: query_object,
          pagination: pagination_object,
          order: order_object
        )

        @cities = cities.success
        serialize!(City, @cities, paginate(@cities))
      end
    end
  end
end

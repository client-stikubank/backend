# frozen_string_literal: true

module Admin
  class CitiesController < AdminController
    before_action :set_city, only: %i[show update destroy]

    def index
      cities = CityService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @cities = cities.success
      serialize!(City, @cities, paginate(@cities))
    end

    def create
      city = CityService::Create.new(params: city_params).call

      city.instance_of?(City) ? serialize!(City, city) : error!(city.failure[1])
    end

    def update
      city = CityService::Update.new(params: city_params, record: @city).call

      city.instance_of?(City) ? serialize!(City, city) : error!(city.failure[1])
    end

    def show
      @city ? serialize!(City, @city) : error!(I18n.t('c.errors.data_not_found'))
    end
    
    def destroy
      city = CityService::Destroy.new(record: @city).call

      city.instance_of?(City) ? destroyed! : error!(city.failure[1])
    end

    private

    def city_params
      params.require(:city).permit(:name, :province_id)
    end

    def set_city
      @city = City.find_by(id: params[:id])
    end
  end
end

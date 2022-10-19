# frozen_string_literal: true

module Admin
  class ProvincesController < AdminController
    before_action :set_province, only: %i[show update destroy]

    def index
      provinces = ProvinceService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @provinces = provinces.success
      serialize!(Province, @provinces, paginate(@provinces))
    end

    def create
      province = ProvinceService::Create.new(params: province_params).call

      province.instance_of?(Province) ? serialize!(Province, province) : error!(province.failure[1])
    end

    def update
      province = ProvinceService::Update.new(params: province_params, record: @province).call

      province.instance_of?(Province) ? serialize!(Province, province) : error!(province.failure[1])
    end

    def show
      @province ? serialize!(Province, @province) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      province = ProvinceService::Destroy.new(record: @province).call

      province.instance_of?(Province) ? destroyed! : error!(province.failure[1])
    end

    private

    def province_params
      params.require(:province).permit(:name)
    end

    def set_province
      @province = Province.find_by(id: params[:id])
    end
  end
end

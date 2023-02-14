# frozen_string_literal: true

module Admin
  class GlobalSettingsController < AdminController
    before_action :set_global_setting, only: %i[show update destroy]

    def index
      global_settings = GlobalSettingService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @global_settings = global_settings.success
      serialize!(GlobalSetting, @global_settings, paginate(@global_settings))
    end

    def create
      global_setting = GlobalSettingService::Create.new(params: global_setting_params).call

      global_setting.instance_of?(GlobalSetting) ? serialize!(GlobalSetting, global_setting) : error!(global_setting.failure[1])
    end

    def update
      global_setting = GlobalSettingService::Update.new(params: global_setting_params, record: @global_setting).call

      global_setting.instance_of?(GlobalSetting) ? serialize!(GlobalSetting, global_setting) : error!(global_setting.failure[1])
    end

    def show
      @global_setting ? serialize!(GlobalSetting, @global_setting) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      global_setting = GlobalSettingService::Destroy.new(record: @global_setting).call

      global_setting.instance_of?(GlobalSetting) ? destroyed! : error!(global_setting.failure[1])
    end

    private

    def global_setting_params
      params.require(:global_setting).permit(:name, :code, :value)
    end

    def set_global_setting
      @global_setting = GlobalSetting.find_by(id: params[:id])
    end
  end
end

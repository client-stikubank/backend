module Api
  module V1
    class GlobalSettingsController < MobileController
      before_action :set_global_setting, only: :show

      def show
        @global_setting ? serialize!(GlobalSetting, @global_setting) : error!(I18n.t('c.errors.data_not_found'))
      end

      private

      def set_global_setting
        @global_setting = GlobalSetting.find_by(code: params[:code])
      end
    end
  end
end

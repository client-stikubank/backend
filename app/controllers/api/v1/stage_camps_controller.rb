module Api
  module V1
    class StageCampsController < MobileController
      before_action :set_stage_camp, only: :show

      def show
        @stage_camp ? serialize!('StageCampDetail', @stage_camp) : error!(I18n.t('c.errors.data_not_found'))
      end

      private

      def set_stage_camp
        @stage_camp = StageCamp.find(params[:id])
      end
    end
  end
end

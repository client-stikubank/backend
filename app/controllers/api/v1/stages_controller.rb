module Api
  module V1
    class StagesController < MobileController
      before_action :set_stage, only: :show

      def show
        @stage ? serialize!(Stage, @stage) : error!(I18n.t('c.errors.data_not_found'))
      end

      private

      def set_stage
        @stage = Stage.find(params[:id])
      end
    end
  end
end

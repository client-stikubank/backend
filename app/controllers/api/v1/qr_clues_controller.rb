module Api
  module V1
    class QrCluesController < MobileController
      before_action :set_qr_clue, only: :show

      def show
        @qr_clue ? serialize!(QrClue, @qr_clue) : error!(I18n.t('c.errors.data_not_found'))
      end

      private

      def set_qr_clue
        @qr_clue = QrClue.find_by(id: params[:id])
      end
    end
  end
end

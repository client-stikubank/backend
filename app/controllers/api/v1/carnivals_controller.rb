module Api
  module V1
    class CarnivalsController < MobileController
      before_action :active_camp, only: %i[confirm_active_camp claim_active_camp]

      def active_carnival
        serialize!('ActiveCarnival', current_user)
      end

      def confirm_active_camp
        if @active_camp.stage_camp_schedule.online?
          error_message = 'Konfirmasi pelatihan 1 jam sebelum pelatihan dimulai'
          error!(error_message) unless @active_camp.stage_camp_schedule.reminded?
        else
          error_message = 'Maaf kamu sudah tidak bisa melakukan konfirmasi kehadiran'
          error!(error_message) if @active_camp.stage_camp_schedule.completed?
        end

        if @active_camp.confirmed!
          render json: { success: true }
        else
          error!('Gagal konfirmasi pelatihan')
        end
      end

      def claim_active_camp
        error!(I18n.t('c.errors.cant_claim')) unless @active_camp.confirmed?
        error!(I18n.t('c.errors.not_in_claim_time')) unless @active_camp.stage_camp_schedule.claim_time?

        if @active_camp.finish_and_claim!
          render json: { success: true }
        else
          error!(I18n.t('c.errors.claim_fail'))
        end
      end

      private

      def active_camp
        @active_camp = current_user.active_camps.find_by(id: params[:id])
      end
    end
  end
end

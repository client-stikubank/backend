module Api
  module V1
    class CarnivalsController < MobileController
      def active_carnival
        serialize!('ActiveCarnival', current_user)
      end

      def confirm_active_camp
        error_message = 'Konfirmasi pelatihan 1 jam sebelum pelatihan dimulai'

        error!(error_message) unless current_user.active_camp.stage_camp_schedule.reminded?

        if current_user.active_camp.confirmed!
          render json: { success: true }
        else
          error!('Gagal konfirmasi pelatihan')
        end
      end

      def claim_active_camp
        error!(I18n.t('c.errors.cant_claim')) unless current_user.active_camp.confirmed?
        error!(I18n.t('c.errors.not_in_claim_time')) unless current_user.active_camp.stage_camp_schedule.claim_time?

        if current_user.active_camp.finish!
          render json: { success: true }
        else
          error!(I18n.t('c.errors.claim_fail'))
        end
      end
    end
  end
end

module Api
  module V1
    class CarnivalsController < MobileController
      def active_carnival
        @carnival = Carnival.active

        @carnival ? serialize!('CarnivalDetail', @carnival) : error!(I18n.t('controllers.errors.data_not_found'))
      end
    end
  end
end

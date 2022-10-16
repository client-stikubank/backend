module Api
  module V1
    class CarnivalsController < MobileController
      def active_carnival
        serialize!('ActiveCarnival', current_user)
      end
    end
  end
end

# frozen_string_literal: true

module Admin
  class CampsController < AdminController
    before_action :set_camp, only: %i[update destroy]

    def index
      camps = CampService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @camps = camps.success
      serialize!(Camp, @camps, paginate(@camps))
    end

    def create
      camp = CampService::Create.new(params: camp_params).call
      camp ? serialize!(Camp, camp) : error!(camp.failure[1])
    end

    def update
      camp = CampService::Update.new(params: camp_params, record: @camp).call
      camp ? serialize!(Camp, camp) : error!(camp.failure[1])
    end

    def destroy
      camp = CampService::Destroy.new(record: @camp).call
      camp ? serialize!(Camp, camp) : error!(camp.failure[1])
    end

    private

    def camp_params
      params.require(:camp).permit(:title, :description, :level, :status)
    end

    def set_camp
      @camp = Camp.find_by(id: params[:id])
    end
  end
end

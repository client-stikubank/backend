# frozen_string_literal: true

module Admin
  class StageCampsController < AdminController
    before_action :set_stage_camp, only: %i[update destroy]

    def index
      stage_camps = StageCampService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @stage_camps = stage_camps.success
      serialize!(StageCamp, @stage_camps, paginate(@stage_camps))
    end

    def create
      stage_camp = StageCampService::Create.new(params: stage_camp_params).call
      stage_camp ? serialize!(StageCamp, stage_camp) : error!(stage_camp.failure[1])
    end

    def update
      stage_camp = StageCampService::Update.new(params: stage_camp_params, record: @stage_camp).call
      stage_camp ? serialize!(StageCamp, stage_camp) : error!(stage_camp.failure[1])
    end

    def destroy
      stage_camp = stage_camp = StageCampService::Destroy.new(record: @stage_camp).call
      stage_camp ? serialize!(StageCamp, stage_camp) : error!(stage_camp.failure[1])
    end

    private

    def stage_camp_params
      params.require(:stage_camp).permit(:stage_id, :camp_id)
    end

    def set_stage_camp
      @stage_camp = StageCamp.find_by(id: params[:id])
    end
  end
end
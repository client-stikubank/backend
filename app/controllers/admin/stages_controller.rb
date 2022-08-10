# frozen_string_literal: true

module Admin
  class StagesController < AdminController
    before_action :set_stage, only: %i[update]

    def update
      stage = StageService::Update.new(params: stage_params, record: @stage).call
      stage ? serialize!(Stage, stage) : error!(stage.failure[1])
    end

    private

    def stage_params
      params.require(:stage).permit(:name)
    end

    def set_stage
      @stage = Stage.find_by(id: params[:id])
    end
  end
end
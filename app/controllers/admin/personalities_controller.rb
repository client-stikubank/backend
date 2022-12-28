# frozen_string_literal: true

module Admin
  class PersonalitiesController < AdminController
    before_action :set_personality, only: %i[show update destroy]

    def index
      personalities = PersonalityService::List.new.call(
        query: query_object,
        pagination: pagination_object,
        order: order_object
      )

      @personalities = personalities.success
      serialize!(Personality, @personalities, paginate(@personalities))
    end

    def create
      personality = PersonalityService::Create.new(params: personality_params).call

      personality.instance_of?(Personality) ? serialize!(Personality, personality) : error!(personality.failure[1])
    end

    def update
      personality = PersonalityService::Update.new(params: personality_params, record: @personality).call

      personality.instance_of?(Personality) ? serialize!(Personality, personality) : error!(personality.failure[1])
    end

    def show
      @personality ? serialize!(Personality, @personality) : error!(I18n.t('c.errors.data_not_found'))
    end

    def destroy
      personality = PersonalityService::Destroy.new(record: @personality).call

      personality.instance_of?(Personality) ? destroyed! : error!(personality.failure[1])
    end

    private

    def personality_params
      params.require(:personality).permit(:code, :name, :image, :description)
    end

    def set_personality
      @personality = Personality.find_by(id: params[:id])
    end
  end
end

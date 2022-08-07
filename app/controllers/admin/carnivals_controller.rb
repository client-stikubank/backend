# frozen_string_literal: true

module Admin
  class CarnivalsController < AdminController
    def index
      service = CarnivalService::List.new.call(
        query: query_object,
        pagination: pagination_object
      )

      @carnivals = service.success
      render json: { data: @carnivals, pagination: paginate(@carnivals) }
    end

    def create
      @form = CarnivalForm.new(Carnival.new)

      unless @form.validate(carnival_params)
        return render json: to_json_form_errors(@form), status: :unprocessable_entity
      end

      @form.save do |form_params|
        service = CarnivalService::Create.new(params: form_params.deep_symbolize_keys).call

        return render json: service, status: :created if service

        render json: { errors: service.failure[1] }, status: :unprocessable_entity
      end
    end

    private

    def carnival_params
      params.require(:carnival).permit(:name, :finished_at)
    end
  end
end
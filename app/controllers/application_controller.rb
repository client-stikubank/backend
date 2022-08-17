# frozen_string_literal: true

class ApplicationController < ActionController::API
  include FormValidatorHelper

  private

  def pagination_object
    ParameterObject::Pagination.new(params[:page], params[:per_page])
  end

  def query_object
    ParameterObject::Query.new(params[:query])
  end

  def order_object
    return unless params[:sort_field] && params[:sort_order]

    "#{params[:sort_field]} #{params[:sort_order]}"
  end

  def serialize!(klass, records, pagination = nil)
    klass = "#{klass}Serializer".classify.safe_constantize
    response = klass.new(records).serializable_hash
    response = response.merge!({ pagination: pagination }) if pagination
    render json: response
  end

  def to_json_form_errors(form)
    errors = form_errors_to_json(form)

    { errors: }.to_json
  end

  def error!(message)
    render json: { errors: message }, status: :unprocessable_entity
  end
end

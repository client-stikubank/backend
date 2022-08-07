# frozen_string_literal: true

require 'reform/form/coercion'

class CarnivalForm < Reform::Form
  feature Coercion

  property :name
  property :finished_at

  validation do
    config.messages.backend = :i18n

    params do
      required(:name).filled(:str?)
      optional(:finished_at)
    end

    rule(:finished_at) do
      key.failure(I18n.t('forms.carnival_form.errors.less_than_current_time')) if value && value < Time.zone.now
    end
  end
end

# frozen_string_literal: true

class MobileController < AuthenticatedController
  include RoleHelper
  include ApplicationHelper

  before_action :authenticate_mobile!
end

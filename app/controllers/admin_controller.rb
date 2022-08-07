# frozen_string_literal: true

class AdminController < AuthenticatedController
  include RoleHelper
  include ApplicationHelper

  before_action :authenticate_admin!
end

# frozen_string_literal: true

class AdminController < AuthenticatedController
  include RoleHelper
  include ApplicationHelper

  load_and_authorize_resource

  before_action :authenticate_admin!
end

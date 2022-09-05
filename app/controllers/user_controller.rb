# frozen_string_literal: true

class UserController < AuthenticatedController
  include RoleHelper
  include ApplicationHelper

  before_action :authenticate_user!
end

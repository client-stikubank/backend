# frozen_string_literal: true

class User < ApplicationRecord
  include Authenticable

  enum role: %i[admin user]
end

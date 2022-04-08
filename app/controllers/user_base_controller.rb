# frozen_string_literal: true

class UserBaseController < BaseController
  before_action :authenticate_user!
end

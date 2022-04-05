class UserBaseController < BaseController
  before_action :authenticate_user!
end

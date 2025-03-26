class ListUsersController < ApplicationController
  before_action :authenticate_user!
  def index
    detector = DeviceDetector.new(request.user_agent)
    @device = {device: detector.device_type, user: current_user.email}
  end
end

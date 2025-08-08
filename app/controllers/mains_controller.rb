class MainsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html {  }
      format.turbo_stream
    end
  end
end
